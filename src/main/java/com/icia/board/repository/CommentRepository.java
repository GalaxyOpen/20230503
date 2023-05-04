package com.icia.board.repository;

import com.icia.board.dto.BoardDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class CommentRepository {
    @Autowired
    private SqlSessionTemplate sql;
    public List<BoardDTO> findAll() {
        return sql.selectList("Comment.findAll");
    }
}
