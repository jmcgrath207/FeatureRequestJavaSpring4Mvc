package com.johnmcgrath.daoInterface;



import com.johnmcgrath.model.ClientViewObj;

import java.util.List;

public interface ClientViewPostgre {


    // Retrieve all organizations from the table.
    public List<ClientViewObj> getAllCase();
}
