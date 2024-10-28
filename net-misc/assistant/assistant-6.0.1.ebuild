# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit xdg unpacker

DESCRIPTION="Ассистент - удобный инструмент для безопасного удаленного доступа."
HOMEPAGE="https://мойассистент.рф/"
SRC_URI="
https://xn--80akicokc0aablc.xn--p1ai/%D1%81%D0%BA%D0%B0%D1%87%D0%B0%D1%82%D1%8C/Download/1089 -> ${P}.deb
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

# Зависимости для запуска этой программы
RDEPEND="
	!net-misc/cassistant
	app-shells/bash
	x11-libs/gtk+:2[cups(+)]
	media-libs/libv4l
"

RESTRICT="bindist mirror strip"

S=${WORKDIR}

ASISTDIR="opt/${PN}"
SCRIPTS_DIR="/${ASISTDIR}/scripts"

pkg_setup() {

	# Sandbox Disabled

	CRON_REGEXP_PATTERN="^\*\/1 \* \* \* \* root \/opt\/assistant\/scripts\/ast_restart\.sh$"
	CRON_FILE="/etc/crontab"
	sed -i "/${CRON_REGEXP_PATTERN}/d" ${CRON_FILE}

	# Завершаем процессы, иначе не дают обновить или преустановить ранее установленную версию
	killall assistant 2> /dev/null
	killall asts 2> /dev/null

}

src_install() {

	mv * "${D}" || die
	sed -i -E -e '/^\s+eselect rc stop zassistantd/d' "${D}${SCRIPTS_DIR}/daemon.sh"

}

pkg_preinst() {

	# Sandbox	Disabled

	# Завершаем процессы, иначе не дают обновить или преустановить ранее установленную версию
	killall assistant 2> /dev/null
	killall asts 2> /dev/null

}

pkg_postinst() {

	# Sandbox	Disabled

	# Исправляем права на файлы и папки
	chmod -R +x /${ASISTDIR}/{bin,lang}
	chmod -R +x ${SCRIPTS_DIR}
	mkdir -p /${ASISTDIR}/{chat,log,screenshot,video}
	chmod -R a+rw /${ASISTDIR}/{chat,license,log,screenshot,video}

	${SCRIPTS_DIR}/setup.sh --install

	xdg_desktop_database_update
	xdg_icon_cache_update

}

pkg_prerm() {

	killall assistant 2> /dev/null
	killall asts 2> /dev/null

	# При новой установке REPLACING_VERSIONS = "", при новой установке pkg_postrm() не выполняется.
	# При удалении REPLACING_VERSIONS не вычисляется, этап pkg_postinst() не выполняется.
	# При удалении REPLACED_BY_VERSION = "", при новой установке pkg_postrm() не выполняется.
	# При обновлении или переустановки выполняются этапы pkg_postinst() и pkg_postrm()
	# и, соответственно, переменные REPLACING_VERSIONS и REPLACED_BY_VERSION имеют ненулевое значение.
	# Таким образом мы можем определить, что пакет устанавливается, обновляется, переустанавливается поверх или удаляется
	# и выстраивать соответствующую логику.

	if [ "${REPLACED_BY_VERSION}" = "" ]; then
		# Удалить ярлык
		rm -f /usr/share/applications/assistant.desktop || die

		if which rc-update >/dev/null 2>&1; then
			# Зачистка мусора
			rc-update delete zassistantd
			/etc/init.d/zassistantd stop

			# Удалить службу
			rm -f /etc/init.d/zassistantd || die
		fi

		${SCRIPTS_DIR}/setup.sh --uninstall

		# Удалить каталог с журналами после удаления
		rm -r -f /opt/assistant || die
		rm -r -f /.config/assistant || die
	fi

}

pkg_postrm() {

	if [ "${REPLACED_BY_VERSION}" = "" ]; then
		elog "Пакет окончательно удаляется"

		# Удалить каталог с журналами после удаления
		rm -r -f /opt/assistant || die
		rm -r -f /.config/assistant || die
	fi

	xdg_desktop_database_update
	xdg_icon_cache_update

}
