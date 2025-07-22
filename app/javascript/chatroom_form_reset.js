document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("message-form");
    const messageInput = document.getElementById("message-input");

    if (form) {
        form.addEventListener("turbo:submit-end", function (event) {
            if (event.detail.success) {
                messageInput.value = "";
                messageInput.focus();
            } else {
                console.log("Error sending message");
            }
        });
    }
});
