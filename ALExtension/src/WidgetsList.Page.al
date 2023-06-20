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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(productionTime; Rec."Production Time")
                {
                    Caption = 'Production Time';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(approvalState; Rec."Approval State")
                {
                    Caption = 'Approval State';
                }
            }
        }
    }
}