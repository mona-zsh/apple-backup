.headers on
.mode csv

SELECT message.text, message.account, message.date, message.date_read, message.date_delivered, chat.chat_identifier, chat.account_login, attachment.filename, attachment.mime_type, attachment.total_bytes, handle.id
FROM message
INNER JOIN chat_message_join ON message.ROWID = chat_message_join.message_id
INNER JOIN chat ON chat.ROWID = chat_message_join.chat_id
INNER JOIN chat_handle_join ON chat.ROWID = chat_handle_join.chat_id
INNER JOIN handle ON handle.ROWID = chat_handle_join.handle_id
LEFT JOIN message_attachment_join ON message.ROWID = message_attachment_join.message_id
LEFT JOIN attachment ON attachment.ROWID = message_attachment_join.attachment_id
;

