//let myLecture = []      // 수강 신청한 강의를 담아둘 배열 선언
function apply(event) {       // 수강 신청 버튼 함수
	let form = event.target.closest("form");
    let isEnrolled = form.querySelector("input[name='is_enrolled']").value;
    let lectureName = form.querySelector("input[name='subject_name']").value;

    if (isEnrolled === "Y") {
        alert("이미 수강 신청한 강의입니다.");
    } else {
        alert("'" + lectureName + "' 수강 신청 완료했습니다!");
        form.submit();
    }
}
function test(){
	alert("test");
}

/* 성적보기 */
let currentVisibleSubjectId = null;

function detailScore(button) {
    const row = button.closest("td");			//버튼에서 가장 가까운 td 호출
    const subjectId = row.querySelector("input[name='subject_id']").value;	//해당 td안의 input type="hidden" name="subject_id"의 값을 가져옴

    const target = document.querySelector(`.scoreRow[data-subject-id='${subjectId}']`);
	//찾은 과목에 해당하는 div class="scoreRow" data-subject-id="subjectId"를 찾는다(성적 상세내용을 담고 있는 div)

    // 이미 보이고 있는 성적창이면 -> 숨기기
    if (currentVisibleSubjectId === subjectId) {
        if (target) {
            target.style.display = "none";
            document.getElementById("detailScore").style.display = "none";
            currentVisibleSubjectId = null; // 다시 초기화
        }
        return;
    }

    // 모든 성적창 숨기기
    document.querySelectorAll(".scoreRow").forEach(div => {
        div.style.display = "none";
    });

    // 해당 과목 성적창만 보여주기
    if (target) {
        target.style.display = "block";
        document.getElementById("detailScore").style.display = "block";
        currentVisibleSubjectId = subjectId;
    }
}

/* 출결 상세보기 */
let currentVisibleAttendanceSubjectId = null;

function detailAttendance(button) {
    const row = button.closest("td"); // 버튼이 속한 td
    const subjectId = row.querySelector("input[name='subject_id']").value; // 숨겨진 subject_id 값 가져오기

    const target = document.querySelector(`.attendanceRow[data-subject-id='${subjectId}']`);
    // 해당 과목의 attendanceRow div를 찾음

    // 이미 보이는 경우 → 숨기기
    if (currentVisibleAttendanceSubjectId === subjectId) {
        if (target) {
            target.style.display = "none";
            currentVisibleAttendanceSubjectId = null;
        }
        return;
    }

    // 모든 attendanceRow 숨기기
    document.querySelectorAll(".attendanceRow").forEach(div => {
        div.style.display = "none";
    });

    // 선택된 과목의 attendanceRow만 보이게
    if (target) {
        target.style.display = "block";
        currentVisibleAttendanceSubjectId = subjectId;
    }
}

/* 출석 이의신청 */
let myAttendance = [];     // 이의신청 완료한 출석 담아두는 배열
function attendanceDissent(event) {
  let row = event.target.closest("tr");                                    // 클릭된 버튼의 부모 요소인 <tr> 찾기
  let dissentAttendance = row.querySelector("#attendanceLecture").textContent.trim();  // 해당 행에서 id가 "attendance"인 요소 찾기
  if (myAttendance.includes(dissentAttendance)) {      // 가져온 출석 행이 이미 이의신청한 출석일 때(배열에 저장되어 있을 때)
    alert("이미 이의 신청했습니다.")
  } else {                                   // 가져온 출석 행이 첫 이의신청일 때
    myAttendance.push(dissentAttendance);            // 배열에 출석 행 저장
    alert("'" + dissentAttendance + "' 출석 이의 신청 완료했습니다!")
  }
}

/* 성적 이의신청 */
let myDissent = [];
function dissent(event) {
	let row = event.target.closest("tr"); // 버튼이 눌린 tr 찾기
	let dissentLecture = row.querySelector("#lectureName").textContent.trim(); // 과목명

	if (myDissent.includes(dissentLecture)) {
    	alert("이미 이의 신청한 강의입니다.");
	} else {
		myDissent.push(dissentLecture); // 배열에 저장
    	alert("'" + dissentLecture + "' 이의 신청 완료했습니다!");
	}
}

/* 학생 개인정보 조회/수정 이미지 설정 */
function loadImage(event) { // 학생 프로필 이미지 설정
  var image = document.getElementById('profileImage');
  var button = document.getElementById('imageBtn');

  var file = event.target.files[0];
  if (file) {
    var reader = new FileReader();
    reader.onload = function (e) {
      image.src = e.target.result;
      image.style.display = 'block';  // 이미지를 보이게 설정
      button.style.display = 'none';  // 버튼은 숨김
    };
    reader.readAsDataURL(file);
  }
}

/* 학생 프로필 수정 및 저장 */
function saveData() {
  var hakbun = document.getElementById("hakbun").value;
  var major = document.getElementById("major").value;
  var name = document.getElementById("name").value;
  var course = document.getElementById("course").value;
  var etc = document.getElementById("etc").value;
  var birthDate = document.getElementById("birthDate").value;
  var phoneNumber = document.getElementById("phoneNumber").value;
  var address = document.getElementById("address").value;
  var email = document.getElementById("email").value;
  var advisor = document.getElementById("advisor").value;

  if (hakbun && major && name && course && birthDate && phoneNumber && address && email && advisor) {
    alert("정보가 저장되었습니다!");
	document.getElementById("profileForm").submit();
  } else {
    alert("필수 입력칸이 비어있습니다.");
  }
}

/*
document.addEventListener("DOMContentLoaded", function () {
  const searchInput = document.querySelector(".inputSearch");
  const searchForm = document.querySelector("form");

  // 저장된 검색어 유지
  if (localStorage.getItem("searchTerm")) {
      searchInput.value = localStorage.getItem("searchTerm");
  }

  searchForm.addEventListener("submit", function (event) {
      event.preventDefault(); // 기본 동작(새로고침) 방지

      const searchTerm = searchInput.value.trim();
      localStorage.setItem("searchTerm", searchTerm); // 검색어 저장

      filterTable(searchTerm);
  });

  function filterTable(searchTerm) {
      const rows = document.querySelectorAll("tbody tr");

      rows.forEach(row => {
          const subjectName = row.cells[6].textContent; // 교과목명 컬럼
          if (subjectName.includes(searchTerm) || searchTerm === "") {
              row.style.display = ""; // 일치하면 표시
          } else {
              row.style.display = "none"; // 불일치하면 숨김
          }
      });
  }

  // 페이지 로드 시 검색 필터 적용
  filterTable(searchInput.value);
});
*/

