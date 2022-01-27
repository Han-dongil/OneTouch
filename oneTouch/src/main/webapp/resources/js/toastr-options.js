//VO 에서 임의 CRUD 값을 받아와서 이미 입력된 값으면 R 이란느 값이
// toastr 옵션 옵션설정이 위에 먼저 와있어야 설정이 먹는다.
toastr.options = {
       "closeButton": true,  //닫기버튼(X 표시)
       "debug": false,       //디버그
       "newestOnTop": false,
       "progressBar": true,  //진행률 표시
       "positionClass": "toast-top-center",
       "preventDuplicates": false,    //중복 방지(같은거 여러개 안뜸)
       "onclick": null,             //알림창 클릭시 alert 창 활성화 (다른것도 되는지는 연구해봐야함)
       "showDuration": "3",
       "hideDuration": "100",
       "timeOut": "1500",   //사라지는데 걸리는 시간
       "extendedTimeOut": "1000",  //마우스 올리고 연장된 시간
       "showEasing": "swing",
       "hideEasing": "linear",
       "showMethod": "fadeIn",
       "hideMethod": "fadeOut",
       "tapToDismiss": false,
       "closeHtml": "확인"
     }
//success: 성공(초록) , info:정보(하늘색) , warning:경고(주황) , error:에러(빨강)