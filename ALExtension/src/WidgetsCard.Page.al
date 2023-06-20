page 52335 "Widgets Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Widget;

    layout
    {
        area(Content)
        {
            group(General)
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
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(description; Rec."Description")
                {
                    Caption = 'Description';
                }
                field(approvalState; Rec."Approval State")
                {
                    Caption = 'Approval State';
                    Editable = false;
                }
            }
            group(Production)
            {
                Caption = 'Production Details';
                Editable = Rec."Approval State" <> Rec."Approval State"::Open;

                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit of Measure';
                }
                field(productionTime; Rec."Production Time")
                {
                    Caption = 'Production Time';
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
        area(Processing)
        {
            action(SendApprovalRequest)
            {
                Caption = 'Send Approval Request';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.Validate("Approval State", Rec."Approval State"::Open);
                    Rec.Modify(true);

                    WidgetSentForApproval(Rec.SystemId);
                end;
            }
            action(CancelApprovalRequest)
            {
                Caption = 'Cancel Approval Request';
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

    [ExternalBusinessEvent('WidgetApprovalRequested', 'Approval is requested for widget', 'Triggers when an approval request is sent for a widget.', Enum::EventCategory::Widgets)]
    local procedure WidgetApprovalRequested(WidgetId: Guid)
    begin
    end;
}