table 52333 Widget
{
    Caption = 'Widget';

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
        }
        field(5; "Production Time"; Duration)
        {
            Caption = 'Production Time';
        }
        field(9; "Approval State"; Enum "Approval Status")
        {
            Caption = 'Approval State';
        }
        field(92; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Base Unit of Measure", "Approval State")
        {
        }
        fieldgroup(Brick; "No.", Name, "Base Unit of Measure", "Approval State", Picture)
        {
        }
    }
}