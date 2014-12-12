# opentie-app

opentie のバックエンド

## 何

学園祭実行委員会と (企画) 参加者をつなぐソフトウェア。[orange-tie](https://login.sohosai.tsukuba.ac.jp/) や [駒場祭委員会ウェブシステム](https://www.komabasai.net/65/system/) の FLOSS 実装みたいなもの。

## 設計

バックエンドは[これ](https://github.com/opentie/opentie-app)、フロントエンドは[opentie-console](https://github.com/opentie/opentie-console)。

バックエンドは JSON を吐く API サーバーとして動く。DB は PostgreSQL を使いたい。

![design.jpg](https://github.com/opentie/opentie-app/wiki/design.jpg)
