package com.johnmcgrath.dao;

import java.util.List;

import com.johnmcgrath.model.ClientViewObj;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class ClientViewDao implements ClientViewDaoMysqlInt {




    @Autowired
    private HibernateTemplate hibernateTemplate;



    public ClientViewObj getClientView(String userName) {
        ClientViewObj ClientViewInfo = new ClientViewObj();
        List<?> list = hibernateTemplate.find(" FROM ClientViewObj WHERE client_username=?",
                userName);
        if(!list.isEmpty()) {
            ClientViewInfo = (ClientViewObj)list.get(0);
        }
        return ClientViewInfo;
    }



}