package com.project.board.service;

import com.project.board.domain.User;

public interface JoinService {
    int join(User user) throws Exception;
}