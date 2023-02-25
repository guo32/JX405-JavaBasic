let initPage = () => {
    let temp = new URLSearchParams(window.location.search).get("id");
    let data;
    data = {
        "id": temp
    };

    $.ajax({
        url: "/board/printOne",
        method: "get",
        data: data,
        success: (message) => {
            let result = JSON.parse(message);
            if (result.status == 'success') {
                let data = JSON.parse(result.data);
                printData(data);
            } else {
                Swal.fire({
                    title: "error",
                    text: result.message,
                    icon: "error",
                }).then(() => { // fire()가 끝나고 나서 실행할 코드를 정의
                    location.href = result.nextPath;
                });
            }
        }
    });
    printReply(temp);
}

function printData(data) {
    /*console.log(data);*/
    $('#td-id').text(data.id + "번");
    $('#td-title').text(data.title);
    $('#td-writer').text(data.writerNickname);
    $('#td-entry-date').text(data.entryDate);
    $('#td-modify-date').text(data.modifyDate);
    $('#td-content').append(data.content);

    if (data.isOwned == true) {
        let tr = $(document.createElement("tr"));
        let td = $(document.createElement("td")).attr("colspan", "2");

        let btnUpdate = $(document.createElement("div")).addClass("btn btn-outline-success w-50").text("수정").click(() => {
            location.href = "/board/update.jsp?id=" + data.id;
        });
        let btnDelete = $(document.createElement("div")).addClass("btn btn-outline-danger w-50").text("삭제").click(() => {
            let delData = {
                "id": data.id,
            };
            $.ajax({
                url: "/board/delete",
                method: "post",
                data: data,
                success: (message) => {
                    let response = JSON.parse(message);
                    if (response.status == 'success') {
                        Swal.fire({
                            title: "삭제 성공",
                            text: "글이 성공적으로 삭제되었습니다.",
                        }).then(() => {
                            location.href = '/board/printList.jsp?id=' + data.id;
                        });
                    } else {
                        Swal.fire({
                            title: "삭제 실패",
                            text: "문제가 발생하여 글을 삭제하지 못했습니다."
                        })
                    }
                }
            });
        });
        $(td).append(btnUpdate);
        $(td).append(btnDelete);
        $(tr).append(td);
        $('#table-board').append(tr);
    }
    /*console.log(typeof (data.isOwned));*/
}
