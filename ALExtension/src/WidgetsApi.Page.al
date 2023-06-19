page 52333 "Widgets API"
{
    PageType = API;
    Caption = 'Widgets';
    APIPublisher = 'ayrton';
    APIGroup = 'techdays';
    APIVersion = 'v0.2023';
    EntityName = 'widget';
    EntitySetName = 'widgets';
    SourceTable = Widget;
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                }
                field(number; Rec."No.")
                {
                    Caption = 'Number';
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
                }
                field(picture; NameValueBufferBlob."Value BLOB")
                {
                    Caption = 'Picture';
                }
            }
        }
    }

    var
        NameValueBufferBlob: Record "Name/Value Buffer" temporary; // This can be any table with a field of type Blob
        ConfigMediaBuffer: Record "Config. Media Buffer" temporary; // This can be any table with a field of type Media


    trigger OnModifyRecord(): Boolean
    begin
        if Rec."Approval State" = Rec."Approval State"::Open then
            Error('The record is waiting for approval!');
    end;

    trigger OnAfterGetRecord()
    var
        TenantMedia: Record "Tenant Media";
        OutStr: OutStream;
        InStr: InStream;
        MediaId: Guid;
        RecordR: RecordRef;
        FieldR: FieldRef;
    begin
        NameValueBufferBlob.DeleteAll();
        NameValueBufferBlob.Init();
        NameValueBufferBlob."Value BLOB".CreateOutStream(OutStr);

        // **BEGIN**
        // If the picture is of type Media, use this code:
        // Rec.Picture.Image.ExportStream(OutStr);

        // If the picture is of type MediaSet, use this code:
        if Rec.Picture.Count > 0 then begin
            // There are more than 1 pictures for this item. We take the first one.
            MediaId := Rec.Picture.Item(1);

            // This is ugly but there is no platform support
            TenantMedia.SetAutoCalcFields(Content);
            if not TenantMedia.Get(MediaID) then
                exit;

            TenantMedia.Content.CreateInStream(InStr);
            CopyStream(OutStr, InStr);
        end;
        // **END**

        NameValueBufferBlob.Insert();
    end;


    [ServiceEnabled]
    procedure Approve()
    begin
        Rec.Validate("Approval State", Rec."Approval State"::Approved);
        Rec.Modify(true);
    end;

    [ServiceEnabled]
    procedure Reject()
    begin
        Rec.Validate("Approval State", Rec."Approval State"::Rejected);
        Rec.Modify(true);
    end;

    [ServiceEnabled]
    procedure CancelApproval()
    begin
        Rec.Validate("Approval State", Rec."Approval State"::Canceled);
        Rec.Modify(true);
    end;

}