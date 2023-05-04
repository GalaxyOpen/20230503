package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;
    public List<BoardDTO> findAll() {
        return commentRepository.findAll();

    }
}
