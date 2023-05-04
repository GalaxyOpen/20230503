package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/board")
public class CommentController {
    @Autowired
    private CommentService commentService;
    @PostMapping("/save")
            public ResponseEntity comment_write(@ModelAttribute BoardDTO boardDTO){
            List<BoardDTO> boardDTOList = commentService.findAll();
            Map<String, Object> resultMap = new HashMap<>();
            resultMap.put("board", boardDTO);
            resultMap.put("boardList", boardDTOList);
            return new ResponseEntity<>(resultMap, HttpStatus.OK);
    }

}
