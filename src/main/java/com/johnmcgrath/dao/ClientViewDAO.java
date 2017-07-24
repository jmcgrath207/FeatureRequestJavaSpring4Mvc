package com.johnmcgrath.dao;

import java.util.List;

import com.johnmcgrath.daoInterface.ClientViewMySql;

import com.johnmcgrath.model.ClientViewObj;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;


@Repository
public class ClientViewDAO implements ClientViewMySql {




    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void save(ClientViewObj p) {
        Session session = this.sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.persist(p);
        tx.commit();
        session.close();
    }


    @SuppressWarnings("unchecked")
    @Override
    public List<ClientViewObj> list() {
        Session session = this.sessionFactory.openSession();
        List<ClientViewObj> personList = session.createQuery("from Person").list();
        session.close();
        return personList;
    }



}
