package com.johnmcgrath.model;





import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import javax.validation.constraints.Future;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name="ClientView")
public class ClientViewObj  implements Serializable {


    private static final long serialVersionUID = 1L;

    @Id
    @Column(name="id")
    private int id;



    @Column(name="client_username")
    @Size(min=5,max=100, message="Client Username must be between 5 and 100 characters")
    @NotNull
    private String client_username;


    @Column(name="case_name")
    @Size(min=5,max=100, message="Case Name must be between 5 and 100 characters")
    @NotNull
    private String case_name;



    @Column(name="priority")
    @NotNull
    private int priority;


    @Column(name="target_date")
    @Future(message = "Date must be in the Future") //must be date in the future
    @NotNull
    private String target_date;


    @Column(name="product_area")
    @Size(min=5,max=100, message="Product Area must be between 5 and 100 characters")
    @NotNull
    private String product_area;


    @Column(name="status")
    @Size(min=5,max=100, message="Status must be between 5 and 100 characters")
    @NotNull
    private String status;


    @Column(name="description")
    @Size(min=5,max=255, message="Description must be between 5 and 100 characters")
    @NotNull
    private String description;




    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getClient_username() {
        return client_username;
    }

    public void setClient_username(String client_username) {
        this.client_username = client_username;
    }

    public String getCase_name() {
        return case_name;
    }

    public void setCase_name(String case_name) {
        this.case_name = case_name;
    }

    public int getPriority() {
        return priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getTarget_date() {
        return target_date;
    }

    public void setTarget_date(String target_date) {
        this.target_date = target_date;
    }

    public String getProduct_area() {
        return product_area;
    }

    public void setProduct_area(String product_area) {
        this.product_area = product_area;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
