FROM ubuntu:18.04

# Installed Packages:
#
# libmono-system-windows-forms4.0-cil, libmono-system-management4.0-cil, libgtk2.0-0
#     Required for bootstrap.
#
# libmono-i18n-cjk4.0-cil
#     Resolves partial text garbling and the error on reading record file.
#
# fonts-takao-pgothic (or noto etc.)
#     Japanese font.
#     This will be applied by running ShogiGUI with `LANG=ja_JP.UTF-8`.
#     (We can check it by fc-match.)
#
# language-pack-ja-base
#     When running with `LANG=ja_JP.UTF-8`, GTK will be say warnings without it.

# for tzdata
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y \
    # mono-runtime and dependencies
    mono-runtime \
    libmono-system-windows-forms4.0-cil \
    libmono-system-management4.0-cil \
    libmono-i18n-cjk4.0-cil \
    libgtk2.0-0 \
    # japanese
    fonts-takao-pgothic \
    language-pack-ja-base \
    # tools
    curl unzip

# Setup tzdata manually.
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

# Download ShogiGUI.
WORKDIR /shogi
RUN curl -LO http://shogigui.siganus.com/shogigui/ShogiGUIv0.0.6.13.zip && \
  unzip ShogiGUIv0.0.6.13.zip && \
  rm ShogiGUIv0.0.6.13.zip
