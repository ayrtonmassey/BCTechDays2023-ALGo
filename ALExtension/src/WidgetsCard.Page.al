page 52335 "Widgets Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Widget;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'General';
                Editable = Rec."Approval State" <> Rec."Approval State"::Open;

                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    Caption = 'Number';
                    Editable = false;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(searchDescription; Rec."Search Description")
                {
                    Caption = 'Search description';
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base unit of measure';
                }
                field(approvalState; Rec."Approval State")
                {
                    Caption = 'Approval state';
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            part(WidgetPicture; "Widget Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(SendForApproval)
            {
                Caption = 'Send for approval';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Validate("Approval State", Rec."Approval State"::Open);
                    Rec.Modify(true);

                    WidgetSentForApproval(Rec.SystemId);
                end;
            }
            action(CancelForApproval)
            {
                Caption = 'Cancel approval';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Validate("Approval State", Rec."Approval State"::Created);
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Rec.Validate("Approval State", Rec."Approval State"::Created);

        Rec.Modify(true);
    end;

    [ExternalBusinessEvent('WidgetSentForApproval', 'Widget is sent for approval', 'Triggers when a widget is sent for approval.', Enum::EventCategory::Widgets)]
    local procedure WidgetSentForApproval(WidgetId: Guid)
    begin
    end;
}