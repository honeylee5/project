package com.project.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.domain.User;

@Repository
public class JoinDaoImpl implements JoinDao {
    @Autowired
    private SqlSession session;
    
    private static String namespace = "com.project.dao.joinMapper.";

    public int join(User user) throws Exception {
        return session.insert(namespace+"join", user);
    }
}