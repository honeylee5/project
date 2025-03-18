package com.project.board.dao;

import com.project.board.domain.User;

public interface JoinDao {
    int join(User user) throws Exception;
}