package com.johnmcgrath.model;





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

    @Id
    @Column(name = "TickerOwnerId")
    private int ticketOwnerId;


    @Column(name = "Title")
    @Size(min = 5, max = 255, message = "Title must be between 5 and 100 characters")
    @NotNull
    private String title;

    @Column(name = "Description")
    @Size(min = 5, message = "Title must be between 5 and 100 characters")
    @NotNull
    private String description;

    @Column(name = "CreationDate", columnDefinition="DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;


    @Id
    @Column(name = "CreationUserId")
    private int creationUserId;


    @Column(name = "UpdateDate", columnDefinition="DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    @Future
    private Date updateDate;


    @Column(name = "UpdateUserId")
    @NotNull
    private int updateUserId;


    @Column(name = "TargetDate", columnDefinition="DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    @Future
    private Date targetDate;


    @Column(name = "DepartmentId")
    @NotNull
    private int departmentId;

    @Column(name = "StatusId")
    @NotNull
    private int statusId;


    @Column(name = "PriorityId")
    @NotNull
    private int PriorityId;


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

    public int getTicketOwnerId() {
        return ticketOwnerId;
    }

    public void setTicketOwnerId(int ticketOwnerId) {
        this.ticketOwnerId = ticketOwnerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreationDate() {
        return epochToUtc(creationDate);
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public int getCreationUserId() {
        return creationUserId;
    }

    public void setCreationUserId(int creationUserId) {
        this.creationUserId = creationUserId;
    }

    public String getUpdateDate() {
        return epochToUtc(updateDate);
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public int getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(int updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getTargetDate() {
        return epochToUtc(targetDate);
    }

    public void setTargetDate(Date targetDate) {
        this.targetDate = targetDate;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public int getPriorityId() {
        return PriorityId;
    }

    public void setPriorityId(int priorityId) {
        PriorityId = priorityId;
    }
}





