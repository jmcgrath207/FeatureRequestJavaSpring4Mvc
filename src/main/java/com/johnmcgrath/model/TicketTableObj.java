package com.johnmcgrath.model;


import org.hibernate.annotations.NamedNativeQueries;
import org.hibernate.annotations.NamedNativeQuery;

import java.io.Serializable;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Future;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;



@NamedNativeQueries({
        @NamedNativeQuery(
                name = "return_latest_tickets",
                query = "CALL return_latest_tickets()",
                resultClass = TicketTableObj.class
        )
})


@Entity
@Table(name="TicketTable")
public class TicketTableObj implements Serializable {

    private String epochToUtc(Date date) {
        Date epochTime = new Date(date.getTime());
        DateFormat utcPattern = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        utcPattern.setTimeZone(TimeZone.getTimeZone("Etc/UTC"));
        return utcPattern.format(epochTime);
    }

    @Id
    @Column(name = "TicketId")
    private int ticketId;

    @Id
    @Column(name = "TicketOriginalId")
    private int ticketOriginalId;


    @Column(name = "TicketTitle")
    @Size(min = 5, max = 255, message = "Title must be between 5 and 100 characters")
    @NotNull
    private String ticketTitle;

    @Column(name = "TicketDescription")
    @NotNull
    private String ticketDescription;

    @Column(name = "StatusDescription")
    @NotNull
    private String statusDescription;

    @Column(name = "DepartmentDescription")
    @NotNull
    private String departmentDescription;

    @Column(name = "PriorityDescription")
    @NotNull
    private String priorityDescription;

    @Column(name = "CreationDate", columnDefinition="DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;


    @Column(name = "UpdateDate", columnDefinition="DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    @Future
    private Date updateDate;


    @Column(name = "TargetDate", columnDefinition="DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    @Future
    private Date targetDate;

    @Column(name = "TicketOwner")
    @NotNull
    private String ticketOwner;

    @Column(name = "CreationUser")
    @NotNull
    private String creationUser;

    @Column(name = "UpdateUser")
    @NotNull
    private String updateUser;

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getTicketOriginalId() {
        return ticketOriginalId;
    }

    public void setTicketOriginalId(int ticketOriginalId) {
        this.ticketOriginalId = ticketOriginalId;
    }

    public String getTicketTitle() {
        return ticketTitle;
    }

    public void setTicketTitle(String ticketTitle) {
        this.ticketTitle = ticketTitle;
    }

    public String getTicketDescription() {
        return ticketDescription;
    }

    public void setTicketDescription(String ticketDescription) {
        this.ticketDescription = ticketDescription;
    }

    public String getStatusDescription() {
        return statusDescription;
    }

    public void setStatusDescription(String statusDescription) {
        this.statusDescription = statusDescription;
    }

    public String getDepartmentDescription() {
        return departmentDescription;
    }

    public void setDepartmentDescription(String departmentDescription) {
        this.departmentDescription = departmentDescription;
    }

    public String getPriorityDescription() {
        return priorityDescription;
    }

    public void setPriorityDescription(String priorityDescription) {
        this.priorityDescription = priorityDescription;
    }

    public String getCreationDate() {
        return epochToUtc(creationDate);
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getUpdateDate() {
        return epochToUtc(updateDate);
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getTargetDate() {
        return epochToUtc(targetDate);
    }

    public void setTargetDate(Date targetDate) {
        this.targetDate = targetDate;
    }

    public String getTicketOwner() {
        return ticketOwner;
    }

    public void setTicketOwner(String ticketOwner) {
        this.ticketOwner = ticketOwner;
    }

    public String getCreationUser() {
        return creationUser;
    }

    public void setCreationUser(String creationUser) {
        this.creationUser = creationUser;
    }

    public String getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(String updateUser) {
        this.updateUser = updateUser;
    }
}





