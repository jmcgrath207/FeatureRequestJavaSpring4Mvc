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




@NamedNativeQueries({
        @NamedNativeQuery(
                name = "return_comments_by_ticketoriginalid",
                query = "CALL return_comments_by_ticketoriginalid(:ticketOriginalId)",
                resultClass = CommentTableObj.class
        )
})


@Entity
@Table(name="CommentTable")
public class CommentTableObj implements Serializable {

    private String epochToUtc(Date date) {
        Date epochTime = new Date(date.getTime());
        DateFormat utcPattern = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        utcPattern.setTimeZone(TimeZone.getTimeZone("Etc/UTC"));
        return utcPattern.format(epochTime);
    }



    @Id
    @Column(name = "CommentId")
    private int commentId;


    @Id
    @Column(name = "CommentOriginalId")
    private int commentOriginalId;


    @Id
    @Column(name = "TicketOriginalId")
    private int ticketOriginalId;


    @Column(name = "CommentDescription")
    @NotNull
    private String commentDescription;

    @Column(name = "CreationDate", columnDefinition = "DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    private Date creationDate;


    @Column(name = "UpdateDate", columnDefinition = "DATETIME")
    @Temporal(TemporalType.TIMESTAMP)
    @Future
    private Date updateDate;

    @Column(name = "CreationUser")
    @NotNull
    private String creationUser;

    @Column(name = "UpdateUser")
    @NotNull
    private String updateUser;



    public int getCommentOriginalId() {
        return commentOriginalId;
    }

    public void setCommentOriginalId(int commentOriginalId) {
        this.commentOriginalId = commentOriginalId;
    }


    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getTicketOriginalId() {
        return ticketOriginalId;
    }

    public void setTicketOriginalId(int ticketOriginalId) {
        this.ticketOriginalId = ticketOriginalId;
    }

    public String getCommentDescription() {
        return commentDescription;
    }

    public void setCommentDescription(String commentDescription) {
        this.commentDescription = commentDescription;
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





