FROM jlesage/firefox:latest
ENV DISPLAY_WIDTH=430
ENV DISPLAY_HEIGHT=932
ENV DARK_MODE=1
RUN mkdir -p /config/profile && \
    printf 'user_pref("general.useragent.override", "Mozilla/5.0 (Linux; Android 15; Pixel 9 Pro XL) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36");\nuser_pref("layout.css.devPixelsPerPx", "1.25");\n' > /config/profile/user.js
EXPOSE 5800
