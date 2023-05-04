package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board") // 공통적으로 /board가 있는걸 앞으로 뺴왔다. @RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

//    @GetMapping("/board/save")
    @GetMapping("/save")
    public String saveForm(){
        return "boardPages/boardSave";
    }
//    @PostMapping("/board/save") // 공통적으로 /board가 있는걸 앞으로 뺴왔다. @RequestMapping("/board")
@PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO) throws IOException {
    System.out.println("boardDTO = " + boardDTO);
        boardService.save(boardDTO);
        return "redirect:/board/";
    }
    @GetMapping("/")
    public String findAll(Model model){
        List<BoardDTO> boardDTOList = boardService.findAll();
        model.addAttribute("boardList", boardDTOList);
        return "boardPages/boardList";
    }
    // /board?id=1 => 상세조회를 할 때에는 파라미터값만 받아주면 된다. 그래서 GetMapping만 써도 된다.
    @GetMapping("")
    public String findById(@RequestParam("id") Long id, Model model){
        boardService.updateHits(id); // 조회수처리를 위한 코드
        BoardDTO boardDTO = boardService.findById(id); //상세조회를 위한 코드
        // 이때 순서가 매우 중요한데 조회수처리 코드가 먼저 올라가야한다(조회수가 올라가고 나서, 상세조회를 불러와야 한다).
        model.addAttribute("board", boardDTO);
        if(boardDTO.getFileAttached()==1){
            List<BoardFileDTO> boardFileDTO = boardService.findFile(id);
            model.addAttribute("boardFileList", boardFileDTO);
            System.out.println("boardFileDTO = " + boardFileDTO);
        }
        return "boardPages/boardDetail";
    }

    @GetMapping("/update")
    public String updateForm(@RequestParam("id") Long id, Model model){
       BoardDTO boardDTO = boardService.findById(id);
       model.addAttribute("board",boardDTO);
       return "boardPages/boardUpdate";
    }
    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO, Model model){
        boardService.update(boardDTO);
        BoardDTO dto = boardService.findById(boardDTO.getId());
        model.addAttribute("board", dto);
        return "redirect:/board?id="+boardDTO.getId();
    }

//    @PostMapping("/update")
//    public String update(@ModelAttribute BoardDTO boardDTO){
//        boardService.update(boardDTO);
//        return "redirect:/board?id="+boardDTO.getId();
//    } -- 이 형태로 수정하면 findById 거치면서 조회수가 올라가는 문제가 있다.
//    위의 findById에서 썼던 객체 boardDTO와 다른 객체로 넣어서 넘겨주면 수정 시에는 조회수가 올라가지 않는다.


    @GetMapping("/delete-check")
    public String deleteCheck(@RequestParam("id") Long id, Model model) {
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        return "boardPages/deleteCheck";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        boardService.delete(id);
        return "redirect:/board/";
    }

}