<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecutre</title>
    <link rel="stylesheet" href="../css/Professor.css">
    <script>
        function createLecture() {
            alert("강의가 생성되었습니다."); // 알림창 표시
        }
    </script>
</head>
<body>
    <div id="wrap">
        <div class="search-container">
            <div>
                <select id="grade">
                    <option value="학년선택" selected disabled>학년 선택</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
                <select id="day">
                    <option value="주간/야간" selected disabled>주간/야간</option>
                    <option value="주간">주간</option>
                    <option value="야간">야간</option>
                </select>
            </div>
            <div class="search-group">
                <input type="text" placeholder="교과목명 입력">
                <button class="btn">검색하기</button>
                <!-- 오른쪽: 강의생성 버튼 -->
                <button class="btn" style="margin-left: 740px;" onclick="createLecture()">강의생성</button>
            </div>
            <!-- 첫 번째 테이블 -->
        <table id="Professor_table">
            <tr class="label">
                <td>No</td>
                <td>주.야</td>
                <td>학년</td>
                <td>교과목명</td>
                <td>이수구분</td>
                <td>학점</td>
                <td>담당교수</td>
                <td>강의시간</td>
                <td>강의실</td>
                <td>인원제한</td>
                <td>수강인원</td>
                <td></td>
            </tr>
            <tr>
                <td>1</td>
                <td>주간</td>
                <td>3</td>
                <td>Java</td>
                <td>전필</td>
                <td>3</td>
                <td>유응구</td>
                <td>화345</td>
                <td>인관105</td>
                <td>40</td>
                <td>40/5</td>
                <td><button>수정</button></td>
            </tr>
            <tr>
                <td>2</td>
                <td>야간</td>
                <td>1</td>
                <td>CSS</td>
                <td>전필</td>
                <td>3</td>
                <td>장성규</td>
                <td>월123</td>
                <td>인관105</td>
                <td>40</td>
                <td>40/5</td>
                <td><button>수정</button></td>
            </tr>
        </table>

        <br>

        <!-- 두 번째 테이블 -->
        <table id="Professor_table">
            <tr class="label">
                <td>No</td>
                <td>학년</td>
                <td>교과목명</td>
                <td>학생명</td>
                <td colspan="8"></td>
            </tr>
            <tr>
                <td>1</td>
                <td>3</td>
                <td>Java</td>
                <td>김학생</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><button>성적관리</button></td>
            </tr>
            <tr>
                <td>2</td>
                <td>1</td>
                <td>CSS</td>
                <td>최학생</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td><button>성적관리</button></td>
            </tr>
        </table>
        </div>

        
    </div>
</body>
</html>
