page 52334 "Widgets List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Widget;
    CardPageId = "Widgets Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(number; Rec."No.")
                {
                    Caption = 'Number';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base unit of measure';
                }
                field(approvalState; Rec."Approval State")
                {
                    Caption = 'Approval state';
                }
            }
        }
    }
}