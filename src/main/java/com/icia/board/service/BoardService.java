package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.dto.PageDTO;
import com.icia.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;
    public void save(BoardDTO boardDTO) throws IOException {
        // 파일 있음, 없음.
        if (boardDTO.getBoardFile().get(0).isEmpty()) {
            // 파일 없음.
            System.out.println("파일없음");
            boardDTO.setFileAttached(0);
            boardRepository.save(boardDTO);
        } else {
            // 파일 있음.
            /*
                1. 파일첨부 여부 값 1로 세팅하고 DB에 제목 등 내용 board_table에 저장 처리
                2. 파일의 이름을 가져오고 DTO 필드값에 세팅
                3. 저장용 파일 이름 만들고 DTO 필드값에 세팅
                4. 로컬에 파일 저장
                5. board_file_table에 저장 처리
             */
            System.out.println("파일있음");
            boardDTO.setFileAttached(1);
            BoardDTO dto = boardRepository.save(boardDTO);
            for (MultipartFile boardFile : boardDTO.getBoardFile()) {
                // 원본 파일 이름 가져오기
                String originalFilename = boardFile.getOriginalFilename();
                System.out.println("originalFilename = " + originalFilename);
                // 저장용 이름 만들기
                System.out.println(System.currentTimeMillis());
                System.out.println(UUID.randomUUID().toString());
                String storedFileName = System.currentTimeMillis() + "-" + originalFilename;
                System.out.println("storedFileName = " + storedFileName);
                // 저장을 위한 BoardFileDTO 세팅
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                boardFileDTO.setOriginalFileName(originalFilename);
                boardFileDTO.setStoredFileName(storedFileName);
                boardFileDTO.setBoardId(dto.getId());
                // 로컬에 파일 저장
                // 저장할 경로 설정 (저장할폴더+저장할이름)
                String savePath = "D:\\springframework_img\\" + storedFileName;
                // 저장처리
               boardFile.transferTo(new File(savePath));
                boardRepository.saveFile(boardFileDTO);
            }


        }
    }
    public List<BoardDTO> findAll() {
        return boardRepository.findAll();
    }
    public void updateHits(Long id) {
        boardRepository.updateHits(id);
    }

    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);
    }

    public void update(BoardDTO boardDTO) {

        boardRepository.update(boardDTO);
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }

    public List<BoardFileDTO> findFile(Long id) {
        return boardRepository.findFile(id);
    }

    public List<BoardDTO> pagingList(int page) {
        int pageLimit = 3; // 한페이지에 보여줄 글 갯수
        int pagingStart = (page-1)*pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        List<BoardDTO> boardDTOList = boardRepository.pagingList(pagingParams);
        return boardDTOList;

    }

    public PageDTO pagingParam(int page) {
        // 우선 총 글의 수는 13개라 가정
        // 이걸 한 페이지에 글을 세개 씩 보여줄 예정임.
        // 홈페이지 하단에 나오는 숫자는 1 2 3
//                                  4 5 6
//                                  7 8 9
        // 이런 식이 될 거임.
        // 사용자가 선택하는 페이지에 따라 그 상황에 맞게 보여줄 예정임.
        // 그런데, 총글이 13개면 나타날 총 페이지 수는 5개임
        // 그런데 1 2 3 은 그냥 3개 나타내면 되지만 2번째 페이지는 4 5 6으로 보여줘도 6페이지는 없기에 4 5만 보여줘야 함(반드시).
        // 이제 아래 페이지를 어떻게 나타낼지 페이징 코드를 아래에 짤 꺼임.

        int pageLimit = 3; // 한페이지에 보여줄 글 갯수
        int blockLimit = 3; // 하단에 보여줄 페이지 번호 갯수

        // 전체 글 갯수를 우선 조회해야 함. Mapper를 보면 알겠지만 mysql에서 썼던 count를 써서 전체 수를 확인함.
        int boardCount = boardRepository.boardCount();

        // 전체 페이지 갯수를 계산
        int maxPage = (int)(Math.ceil((double)boardCount / pageLimit));

        // 시작페이지 값 계산(1,4,7,10 ~~)
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;

        // 마지막 페이지 값 계산
        int endPage = startPage + blockLimit - 1 ;

        // 전체 페이지 갯수가 계산한 endPage보다 작을 때는 endPage 값을 maxPage 값과 같게 세팅
        if(endPage > maxPage){
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }
}

















