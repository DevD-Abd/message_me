document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("message-form");
    const messageInput = document.getElementById("message-input");
    const messagesList = document.getElementById("messages-list");

    // Function to scroll to bottom of messages
    function scrollToBottom() {
        if (messagesList) {
            messagesList.scrollTop = messagesList.scrollHeight;
        }
    }

    // Initial scroll to bottom when page loads
    scrollToBottom();

    if (form) {
        form.addEventListener("turbo:submit-end", function (event) {
            if (event.detail.success) {
                messageInput.value = "";
                messageInput.focus();
                // Scroll to bottom after form submission
                setTimeout(scrollToBottom, 100);
            } else {
                console.log("Error sending message");
            }
        });
    }

    // Scroll to bottom when new messages are received via ActionCable
    if (messagesList) {
        const observer = new MutationObserver(function (mutations) {
            mutations.forEach(function (mutation) {
                if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
                    setTimeout(scrollToBottom, 100);
                }
            });
        });

        observer.observe(messagesList, {
            childList: true,
            subtree: true
        });
    }
});
