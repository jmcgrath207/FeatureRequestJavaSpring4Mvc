package com.johnmcgrath.model;





import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
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


    //private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "TicketId")
    private int ticketId;


    @Column(name = "Title")
    @Size(min = 5, max = 255, message = "Title must be between 5 and 100 characters")
    @NotNull
    private String title;


    @Column(name = "UserId")
    @NotNull
    private int userId;


    @Column(name = "Description")
    @Size(min = 5, message = "Title must be between 5 and 100 characters")
    @NotNull
    private String description;


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


    @Column(name = "DepartmentId")
    @NotNull
    private int departmentId;

    @Column(name = "StatusId")
    @NotNull
    private int statusId;


    @Column(name = "PriorityId")
    @NotNull
    private int PriorityId;


/*    public static long getSerialVersionUID() {
        return serialVersionUID;
    }*/

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreationDate() {
        // TODO: Create Helper Class for Time Converstion
        Date date = new Date(creationDate.getTime());
        DateFormat format = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        format.setTimeZone(TimeZone.getTimeZone("Etc/UTC"));
        String formatted = format.format(date);
        return formatted;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Date getTargetDate() {
        return targetDate;
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




