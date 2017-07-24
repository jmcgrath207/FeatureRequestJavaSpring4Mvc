package com.johnmcgrath.daoInterface;


import com.johnmcgrath.model.ClientViewObj;

import java.util.List;

public interface ClientViewMySql {
    // create a abstraction for Mysql connections

    public void save(ClientViewObj p);

    public List<ClientViewObj> list();
}
