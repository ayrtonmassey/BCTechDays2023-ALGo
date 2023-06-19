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
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Unit of Measure";
            ValidateTableRelation = false;
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
        fieldgroup(DropDown; "No.", Description, "Base Unit of Measure", "Approval State")
        {
        }
        fieldgroup(Brick; "No.", Description, "Base Unit of Measure", "Approval State", Picture)
        {
        }
    }
}