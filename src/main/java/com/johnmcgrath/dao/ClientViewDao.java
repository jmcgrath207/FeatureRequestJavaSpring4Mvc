package com.johnmcgrath.dao;

import java.util.List;

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

    @Transactional(readOnly = true)
    public List<TicketTableObj> getClientView(int userId) {
        System.out.println("test");
        @SuppressWarnings("unchecked")
/*        TypedQuery<TicketTableObj> query=sessionFactory.getCurrentSession().createQuery("from TicketTableObj where userId=:userId");
        query.setParameter("userId",userId);*/
        TypedQuery<TicketTableObj> query=sessionFactory.getCurrentSession().createQuery("from TicketTableObj");
        return query.getResultList();
    }



}