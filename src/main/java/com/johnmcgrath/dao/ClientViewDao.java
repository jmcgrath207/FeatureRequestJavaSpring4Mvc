package com.johnmcgrath.dao;

import java.util.List;

import com.johnmcgrath.model.CommentTableObj;
import com.johnmcgrath.model.TicketTableObj;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.TypedQuery;


@Repository
@Transactional
public class ClientViewDao implements ClientViewDaoInterface {




    @Autowired
    private SessionFactory sessionFactory;


    public void setClientView(TicketTableObj ticketTableObj) {
        sessionFactory.getCurrentSession().save(ticketTableObj);
    }

    @Transactional()
    public List<TicketTableObj> getLatestTicketsDao() {
        @SuppressWarnings("unchecked")
/*        TypedQuery<TicketTableObj> query=sessionFactory.getCurrentSession().createQuery("from TicketTableObj where userId=:userId");
        query.setParameter("userId",userId);*/
        TypedQuery<TicketTableObj> query=sessionFactory.getCurrentSession().getNamedQuery("return_latest_tickets");
        return query.getResultList();
    }

    @Transactional()
    public List<CommentTableObj> getCommentsByTicketOriginalIdDao(int ticketOriginalId) {
        @SuppressWarnings("unchecked")
                TypedQuery<CommentTableObj> query=sessionFactory.getCurrentSession()
                                                               .getNamedQuery("return_comments_by_ticketoriginalid")
                                                               .setParameter("ticketOriginalId", ticketOriginalId);
        return query.getResultList();
    }


    @Transactional()
    public List<CommentTableObj> getCommentHistoryByCommentOriginalIdDao(int commentOriginalId) {
        @SuppressWarnings("unchecked")
        TypedQuery<CommentTableObj> query=sessionFactory.getCurrentSession()
                .getNamedQuery("return_comment_history_by_commentoriginalid")
                .setParameter("commentOriginalId", commentOriginalId);
        return query.getResultList();
    }



}