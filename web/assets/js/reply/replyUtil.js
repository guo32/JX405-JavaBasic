let writeReply = () => {
    let boardId = new URLSearchParams(window.location.search).get("id");
    let formData = {
        "content": $('#input-reply').val(),
        "boardId": boardId,
    };

    $.ajax({
        url: "/reply/write",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "fail") {
                Swal.fire({
                    title: "error",
                    text: "에러가 발생했습니다.",
                    icon: "error",
                });
            }
            location.reload();
        }
    });

}

function printReply(boardId) {
    let sendData = {
        "boardId": boardId,
    };
    $.ajax({
        url: "/reply/selectAll",
        method: "get",
        data: sendData,
        success: (message) => {
            let response = JSON.parse(message);
            console.log(response);
            let replyArray = JSON.parse(response.list);
            console.log(replyArray);

            printList(replyArray);
        }
    });
}

function printList(replyArray) {
    let tr = $(document.createElement("tr"));
    let td = $(document.createElement("td")).attr("colspan", "2");
    if (replyArray.length == 0) {
        td.text("아직 등록된 댓글이 없습니다.");
        $(tr).append(td);
        $('#tbody-reply').append(tr);
    } else {
        replyArray.forEach(reply => {
            console.log(reply);
            let tr = $(document.createElement("tr"));
            let td = $(document.createElement("td")).attr("colspan", "2");
            let str = reply.writer + ": " + reply.content + " at " + reply.date;
            $(td).text(str);
            if (reply.isOwned == true) {
                let btnUpdate = $(document.createElement("div")).addClass("mx-1 badge bg-warning").text("수정");
                btnUpdate.click(() => {
                    /*console.log(reply.id + " update");*/
                    updateUi(td, reply);
                });
                let btnDelete = $(document.createElement("div")).addClass("badge bg-danger").text("삭제");
                btnDelete.click(() => {
                    deleteReply(reply.id);
                });
                $(td).append(btnUpdate);
                $(td).append(btnDelete);
            }
            $(tr).append(td);
            $('#tbody-reply').append(tr);
        });

    }
}

function deleteReply(id) {
    let sendData = {
        "id": id,
    };
    $.ajax({
        url: "/reply/delete",
        method: "get",
        data: sendData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "fail") {
                Swal.fire({
                    "title": "error",
                    "text": "오류가 발생했습니다.",
                })
            }
            location.reload();
        }
    });
}

function updateUi(td, reply) {
    let tr = $(td).parent();
    $(tr).html(""); // 비어있는 tr이 됨

    let form = $(document.createElement("input")).attr("type", "text").addClass("form-control").val(reply.content).attr("id", "input-update" + reply.id);
    let btnUpdate = $(document.createElement("div")).addClass("badge bg-success").click(updateReply(reply)).text("수정");
    let newTd = $(document.createElement("td")).attr("colspan", "2").append(form).append(btnUpdate).attr("style", "display: flex;");
    $(tr).append(newTd);
}

function updateReply(reply) {
    let content = $('#input-update' + reply.id).val();
    let formData = {
        "content": content,
        "id": reply.id,
    };
    $.ajax({
        url: "/reply/update",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "fail") {
                Swal.fire({
                    "title": "error",
                    "text": "오류가 발생했습니다.",
                });
            }
            location.reload();
        },
    });
}