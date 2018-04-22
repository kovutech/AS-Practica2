/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package frontController;

/**
 *
 * @author Jorge
 */
public class Policy {

    private String id;
    private String type;
    private String effectDate;
    private String dueDate;
    private String paymentMethod;
    private float amount;

    public Policy(String id, String type, String effectDate, String dueDate, String paymentMethod, float amount) {
        this.id = id;
        this.type = type;
        this.effectDate = effectDate;
        this.dueDate = dueDate;
        this.paymentMethod = paymentMethod;
        this.amount = amount;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getEffectDate() {
        return effectDate;
    }

    public void setEffectDate(String effectDate) {
        this.effectDate = effectDate;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

}
