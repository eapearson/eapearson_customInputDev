/*
A KBase module: eapearson_customInputDev
*/

module eapearson_customInputDev {
     typedef structure {
        string status;
        string detail;
    } TestResults;

    typedef structure {
        string field1;
        int field2;
        float field3;
    } Type1;


    
    typedef structure {
        string field1;
        list<Type1> field2;
        Type1 field3;
    } Type0;

    typedef structure {
        string field1;
        Type0 field2;
    } CustomInputParams;

    funcdef validate_custom_input(string workspace, string param1, CustomInputParams param2) 
        returns (TestResults result) authentication required;
};
