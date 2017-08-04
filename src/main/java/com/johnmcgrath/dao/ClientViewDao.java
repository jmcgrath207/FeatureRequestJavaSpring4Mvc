package com.johnmcgrath.dao;

import java.util.List;

import com.johnmcgrath.model.ClientViewObj;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.TypedQuery;


@Repository
@Transactional
public class ClientViewDao implements ClientViewDaoMysqlInt {




    @Autowired
    private SessionFactory sessionFactory;


    public void setClientView(ClientViewObj ClientViewObj) {
        sessionFactory.getCurrentSession().save(ClientViewObj);
    }

    @Transactional(readOnly = true)
    public List<ClientViewObj> getClientView(String userName) {
        System.out.println("test");
        @SuppressWarnings("unchecked")
        TypedQuery<ClientViewObj> query=sessionFactory.getCurrentSession().createQuery("from ClientViewObj where client_username=:client_username");
        query.setParameter("client_username",userName);
        return query.getResultList();
    }



}