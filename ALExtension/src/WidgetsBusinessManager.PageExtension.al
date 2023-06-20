pageextension 52333 WidgetsBusinessManager extends "Business Manager Role Center"
{
    actions
    {
        addbefore("Chart of Accounts")
        {
            action(Widgets)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Widgets';
                RunObject = Page "Widgets List";
            }
        }
    }
}