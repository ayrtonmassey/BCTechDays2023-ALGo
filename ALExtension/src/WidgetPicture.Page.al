page 52336 "Widget Picture"
{
    Caption = 'Widget Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Widget;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = Invoicing, Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the item.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    UploadFromDevice();
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = FALSE;

                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    var
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;

    procedure TakeNewPicture()
    begin
        Rec.Find();
        Rec.TestField("No.");
        Rec.TestField(Name);
    end;

    local procedure UploadFromDevice()
    var
        NameValueBufferBlob: Record "Name/Value Buffer" temporary;
        BlobStorage: Codeunit "Temp Blob";
        Filemanagement: Codeunit "File Management";
        BlobFieldRef: FieldRef;
        Instr: InStream;
    begin
        DeleteItemPicture();

        NameValueBufferBlob.SetAutoCalcFields("Value BLOB");
        NameValueBufferBlob.AddNewEntry('Test', 'Test');
        NameValueBufferBlob.FindFirst();

        BlobStorage.FromRecord(NameValueBufferBlob, NameValueBufferBlob.FieldNo("Value BLOB"));
        Filemanagement.BLOBImport(BlobStorage, 'widgetpic');

        BlobStorage.CreateInStream(Instr);
        Rec.Picture.ImportStream(Instr, 'Widget image ' + Format(Rec."No."));

        CurrPage.Update();
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Picture.Count <> 0;
    end;

    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.Picture);
        Rec.Modify(true);
    end;
}