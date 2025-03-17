package com.project.dao;

import com.project.domain.User;

public interface JoinDao {
    int join(User user) throws Exception;
}