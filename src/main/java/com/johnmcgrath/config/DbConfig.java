package com.johnmcgrath.config;

import java.io.IOException;
import java.util.Properties;
import javax.sql.DataSource;



import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;



@Configuration
@EnableTransactionManagement
@PropertySource("classpath:database.properties")
public class DbConfig {



    @Autowired
    private Environment env;

    private NamedParameterJdbcTemplate namedParamJdbcTemplate;


    @Bean
    public HibernateTemplate hibernateTemplate() {
        return new HibernateTemplate(sessionFactory());
    }


    @Bean
    public SessionFactory sessionFactory() {
        LocalSessionFactoryBean lsfb = new LocalSessionFactoryBean();
        lsfb.setDataSource(getDataSource());
        lsfb.setPackagesToScan("com.johnmcgrath.model");
        lsfb.setHibernateProperties(hibernateProperties());
        try {
            lsfb.afterPropertiesSet();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return lsfb.getObject();
    }

    // Grab data info from properties file
    // @Bean
    // public DataSource getDataSource() {
    //     BasicDataSource dataSource = new BasicDataSource();
    //     dataSource.setDriverClassName(env.getProperty("database.driverClassName"));
    //     dataSource.setUrl(env.getProperty("database.url"));
    //     dataSource.setUsername(env.getProperty("database.username"));
    //     dataSource.setPassword(env.getProperty("database.password"));
    //     return dataSource;
    // }


    // grabs JDNI from context.xml
    @Bean
    public DataSource getDataSource() {
        final JndiDataSourceLookup dsLookup = new JndiDataSourceLookup();
        dsLookup.setResourceRef(true);
        DataSource dataSource = dsLookup.getDataSource("jdbc/springdb");
        return dataSource;
    }


    @Bean
    public HibernateTransactionManager hibernateTransactionManager(){
        return new HibernateTransactionManager(sessionFactory());
    }


    private Properties hibernateProperties() {
        Properties properties = new Properties();
        properties.put("hibernate.dialect", env.getProperty("hibernate.dialect"));
        properties.put("hibernate.show_sql", env.getProperty("hibernate.show_sql"));
        properties.put("hibernate.format_sql", env.getProperty("hibernate.format_sql"));
        return properties;
    }
}
