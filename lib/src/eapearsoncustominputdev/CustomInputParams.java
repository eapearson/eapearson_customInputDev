
package eapearsoncustominputdev;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;


/**
 * <p>Original spec-file type: CustomInputParams</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "field1",
    "field2"
})
public class CustomInputParams {

    @JsonProperty("field1")
    private String field1;
    /**
     * <p>Original spec-file type: Type0</p>
     * 
     * 
     */
    @JsonProperty("field2")
    private Type0 field2;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("field1")
    public String getField1() {
        return field1;
    }

    @JsonProperty("field1")
    public void setField1(String field1) {
        this.field1 = field1;
    }

    public CustomInputParams withField1(String field1) {
        this.field1 = field1;
        return this;
    }

    /**
     * <p>Original spec-file type: Type0</p>
     * 
     * 
     */
    @JsonProperty("field2")
    public Type0 getField2() {
        return field2;
    }

    /**
     * <p>Original spec-file type: Type0</p>
     * 
     * 
     */
    @JsonProperty("field2")
    public void setField2(Type0 field2) {
        this.field2 = field2;
    }

    public CustomInputParams withField2(Type0 field2) {
        this.field2 = field2;
        return this;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperties(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

    @Override
    public String toString() {
        return ((((((("CustomInputParams"+" [field1=")+ field1)+", field2=")+ field2)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
