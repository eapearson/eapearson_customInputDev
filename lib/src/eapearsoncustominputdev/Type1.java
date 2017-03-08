
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
 * <p>Original spec-file type: Type1</p>
 * 
 * 
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Generated("com.googlecode.jsonschema2pojo")
@JsonPropertyOrder({
    "field1",
    "field2",
    "field3"
})
public class Type1 {

    @JsonProperty("field1")
    private String field1;
    @JsonProperty("field2")
    private Long field2;
    @JsonProperty("field3")
    private Double field3;
    private Map<String, Object> additionalProperties = new HashMap<String, Object>();

    @JsonProperty("field1")
    public String getField1() {
        return field1;
    }

    @JsonProperty("field1")
    public void setField1(String field1) {
        this.field1 = field1;
    }

    public Type1 withField1(String field1) {
        this.field1 = field1;
        return this;
    }

    @JsonProperty("field2")
    public Long getField2() {
        return field2;
    }

    @JsonProperty("field2")
    public void setField2(Long field2) {
        this.field2 = field2;
    }

    public Type1 withField2(Long field2) {
        this.field2 = field2;
        return this;
    }

    @JsonProperty("field3")
    public Double getField3() {
        return field3;
    }

    @JsonProperty("field3")
    public void setField3(Double field3) {
        this.field3 = field3;
    }

    public Type1 withField3(Double field3) {
        this.field3 = field3;
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
        return ((((((((("Type1"+" [field1=")+ field1)+", field2=")+ field2)+", field3=")+ field3)+", additionalProperties=")+ additionalProperties)+"]");
    }

}
