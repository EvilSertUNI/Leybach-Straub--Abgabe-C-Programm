#!/bin/sh
## partition "run_cmake" {                                            #a0
## start                                                              #a0

## floating note right                                                #a0
# run_cmake.sh - generate Makefiles and build project                 #a0
#                                                                     #a0
# usage: run_cmake.sh [OPTIONS] [MODE-OPTION ][make-options]          #a0
#                                                                     #a0
# MODE OPTIONS                                                        #a0
#   | option            | args | description               | #a0
#   | -R, --release     |      | `Release` build (default) | #a0
#   | -D, --development |      | `Debug` build             | #a0
#                                                                     #a0
# OPTIONS                                                             #a0
#   | option      | args     | description                                               | #a0
#   | -d, --debug |          | do not execute commands                                   | #a0
#   | -h, --help  |          | show this help                                            | #a0
#   | --umlx      | RX[:TYP] | extract UML diagrams matching RX (TYP is empty or `view`) | #a0
#                                                                     #a0
# MAKE-OPTIONS are passed on to make(1).                              #a0
#                                                                     #a0
# Source: `windows - How to change the build type to Release mode in cmake? - Stack Overflow <https://stackoverflow.com/questions/19024259/how-to-change-the-build-type-to-release-mode-in-cmake>`_ #a0
# CMAKE_BUILD_TYPE Specifies the build type for make based            #a0
# generators. This specifies what build type will be built in this    #a0
# tree. Possible values are empty, Debug, Release, RelWithDebInfo and #a0
# Min- SizeRel. This variable is only supported for make based        #a0
# generators. If this variable is supported, then CMake will also     #a0
# provide initial values for the variables with the name              #a0
# CMAKE_C_FLAGS_[Debug|Release|RelWithDebInfo|MinSizeRel]. For example, #a0
# if CMAKE_BUILD_TYPE is Debug, then CMAKE_C_FLAGS_DEBUG will be added #a0
# to the CMAKE_C_FLAGS                                                #a0
#
# Copyright (C) 2025, Ferdinand Leybach

# This file is part of @Package@.

:  # script help
## end note                                                           #a0
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

# (progn (forward-line 1) (snip-insert "gen_hd.template" t t "sh" " --key skip_for_update --key hd-level --value 3 --key hd-title --value 'CONFIGURATION'") (insert ""))

## (progn (forward-line 1) (snip-insert "sh_b.prog-path" t t "sh") (insert ""))
prog_path="${0}"
cd_L="$( cd -L . >/dev/null 2>&1 && printf "%s\n" "-L" )"
pwd_L="$( pwd -L >/dev/null 2>&1 && printf "%s\n" "-L" )"
cd_P="$( cd -P . >/dev/null 2>&1 && printf "%s\n" "-P" )"
pwd_P="$( pwd -P >/dev/null 2>&1 && printf "%s\n" "-P" )"
work_dir="$( cd ${cd_L} .; pwd ${pwd_L} )"
prog_dir="$( dirname "${prog_path}" )"
prog_name="$( basename "${prog_path}" )"
case "${prog_dir}" in
/*) :;;
*)
    prog_dir="$( ( cd ${cd_P} "${prog_dir}" 2>/dev/null && pwd ${pwd_P} ) \
        || printf "%s\n" "${prog_dir}" )"
    prog_path="${prog_dir}/${prog_name}"
    ;;
esac

inst_path_="${prog_path}"
while :
do
    inst_path="${inst_path_}"
    inst_dir="$( dirname "${inst_path}" )"
    inst_name="$( basename "${inst_path}" )"
    inst_path_="$( readlink "${inst_path}" )"
    test -z "${inst_path_}" && break
    case "${inst_path_}" in
    /*) :;;
    *)
        inst_dir_="$( dirname "${inst_path_}" )"
        inst_name_="$( basename "${inst_path_}" )"
        inst_dir__="${inst_dir}/${inst_dir_}"
        inst_dir_="$( ( cd ${cd_P} "${inst_dir__}" 2>/dev/null && pwd ${pwd_P} ) \
            || printf "%s\n" "${inst_dir__}" )"
        inst_path_="${inst_dir_}/${inst_name_}"
        ;;
    esac
done

show_path_info ()
{
    printf >&2 "#   "":DBG:   %-${dbg_fwid-15}s: [%s]\n" "work_dir" "${work_dir}"

    printf >&2 "#   "":DBG:   %-${dbg_fwid-15}s: [%s]\n" "prog_path" "${prog_path}"
    printf >&2 "#   "":DBG:   %-${dbg_fwid-15}s: [%s]\n" "prog_dir" "${prog_dir}"
    printf >&2 "#   "":DBG:   %-${dbg_fwid-15}s: [%s]\n" "prog_name" "${prog_name}"

    printf >&2 "#   "":DBG:   %-${dbg_fwid-15}s: [%s]\n" "inst_path" "${inst_path}"
    printf >&2 "#   "":DBG:   %-${dbg_fwid-15}s: [%s]\n" "inst_dir" "${inst_dir}"
    printf >&2 "#   "":DBG:   %-${dbg_fwid-15}s: [%s]\n" "inst_name" "${inst_name}"
}
# show_path_info; exit

## (progn (forward-line 1) (snip-insert "sh_b.config.sh" t t "sh" " --key x__tdc_input_enable --key x__tdc_all_enable --key x__tdc_tie_cust_enable --key x__cnfs_with_top_dir_check") (insert ""))

# ==================================================
# |||:sec:||| FUNCTIONS
# ==================================================

## (progn (forward-line 1) (snip-insert "sh_f.usage" t t "sh" " --key skip_for_update") (insert "\n"))
usage ()
{
    test x"${prog_path+set}" = xset || \
    prog_path="$( case "${0}" in /*) printf "%s\n" "${0}";; *) printf "%s\n" "$( pwd )/${0}";; esac )"
    ${SED__PROG-sed} -n '/^##/d;s, *#a[0-9]\+,,;3,/^[^#]/{;/^[^#]/d;s,^#\+ \?,,;p;};' "${prog_path-${0}}" \
    | ${SED__PROG-sed} 's,~--,--,g;
s,@filepath@,'"${prog_path-${0}}"',g;
s,@filedir@,'"${prog_dir-$( dirname "${prog_path-${0}}" )}"',g;
s,run_cmake.sh,'"${prog_name-$( basename "${prog_path-${0}}" )}"',g;
'
}

## (progn (forward-line 1) (snip-insert "sh_f.usage_diagram" t t "sh" " --key skip_for_update") (insert ""))

## (snip-expand (forward-line 1) (snip-insert "sh_b.find.python" t t "sh" " --key skip_for_update --key xprefer[23] --key xnon-fatal") (insert "\n"))
## (progn (forward-line 1) (snip-insert "sh_f.hl" t t "sh") (insert ""))
## (progn (forward-line 1) (snip-insert "sh_f.vexec" t t "sh" " --key skip_for_update --key vexec_minimalx") (insert ""))
## (progn (forward-line 1) (snip-insert "sh_f.find_file_in_path" t t "sh" " --key skip_for_update") (insert "\n"))
## (progn (forward-line 1) (snip-insert "sh_f.sed_string" t t "sh" " --key skip_for_update") (insert ""))
## (progn (forward-line 1) (snip-insert "sh_f.single-quote" t t "sh" " --key skip_for_update --key single_quote_micro -v doc,full,minimal,micro") (insert ""))
## (progn (forward-line 1) (snip-insert "sh_f.csv-quote" t t "sh" " --key csv_quote_minimal") (insert "\n"))
## (progn (forward-line 1) (snip-insert "sh_f.split_join" t t "sh" " --key skip_for_update") (insert "\n"))
## (progn (forward-line 1) (snip-insert "sh_f.filter_nl2null" t t "sh") (insert "\n"))
## (progn (forward-line 1) (snip-insert "sh_b.base_ext" t t "sh" " --key skip_for_update --key bext_indent --value 0") (insert ""))
## (progn (forward-line 1) (snip-insert "sh_f.mkstemp" t t "sh") (insert "\n"))
## (progn (forward-line 1) (snip-insert "sh_f.mkdtemp" t t "sh" " --key skip_for_update") (insert ""))

## (progn (forward-line 1) (snip-insert "sh_b.cumulative_function_stepping" t t "sh" " --key skip_for_update") (insert ""))
## (progn (forward-line 1) (snip-insert "sh_wsrfid.f.config_dump" t t "sh") (insert ""))

## (progn (forward-line 1) (snip-insert "sh_cmd.action" t t "sh" " --key skip_for_update --key uml_indx --value 500 --key action --value '@action@'") (insert ""))

## (progn (forward-line -0) (insert "") (snip-insert "sh.scr.sh" t t "sh") (insert ""))
## (progn (forward-line -1) (insert "") (snip-insert "sh.scr.sed" t t "sh") (insert ""))
## (progn (forward-line -2) (insert "") (snip-insert "sh.scr.awk" t t "sh") (insert ""))
## (progn (forward-line -3) (insert "") (snip-insert "sh.scr.perl" t t "sh") (insert ""))
## (progn (forward-line -4) (insert "") (snip-insert "sh.scr.python" t t "sh") (insert ""))

## (progn (forward-line 1) (snip-insert "sh_b.opt-loop" t t "sh" " --key opt-loop-docx --key opt-loop-umlx --key opt-loop-minimalx --key opt-loop-densex") (insert "\n"))
# ==================================================
# |||:sec:||| OPTION PROCESSING
# ==================================================

clear_mode_opts () {
    opt_development=0
    opt_release=0
}
clear_mode_opts
opt_release=1

# ::here::
opt_debug=0
pass_opts=
while :
do
    test x${1+set} = xset || break
    case "${1}" in
    ## (progn (forward-line 1) (snip-insert "sh_b.opt-option" t t "sh" " --key skip_for_update --key opt-minimalx") (insert "\n"))
    # Defining opt_short as `o`, opt_long as `option`, opt_arg as `ARG` => creates option: -o, --option ARG; the value `::fillme::` is considered blank, it does not have to be removed
    # (let ((opt_short "::fillme::") (opt_long "::fillme::") (opt_arg "::fillme::")) (forward-line 2) (snip-insert "sh_b.opt-option" t t "sh" (concat " --key opt-minimalx --key skip_for_update --key opt_short --value " opt_short " --key opt_long --value " opt_long " --key opt_arg --value " opt_arg)))
    # ::here::
    -R|--r|--re|--rel|--rele|--relea|--releas|--release) # --release
        clear_mode_opts
        opt_release=1
        pass_opts="${pass_opts}"' --release'
        ;;
    -D|--dev|--deve|--devel|--develo|--develop|--developm|--developme|--developmen|--development) # --development
        clear_mode_opts
        opt_development=1
        pass_opts="${pass_opts}"' --development'
        ;;
    -d|--deb|--debu|--debug) # --debug
        opt_debug=1
        pass_opts="${pass_opts}"' --debug'
        ;;
    -\?|-h|--h|--he|--hel|--help) # --help
        usage; exit 0
        pass_opts="${pass_opts}"' --help'
        ;;
    --u|--um|--uml|--umlx) # --umlx RX[:TYP]
        opt_umlx="${2-}"
        test x"${2+set}" = xset && shift
        opt_umlx_match="$( printf "%s\n" "${opt_umlx}" | ${SED__PROG-sed} 's,^\([^:]*\)\(:\([^:]*\)\)*.*,\1,' )"
        opt_umlx_type="$( printf "%s\n" "${opt_umlx}" | ${SED__PROG-sed} 's,^\([^:]*\)\(:\([^:]*\)\)*.*,\3,' )"
        out_filt_conv ()
        {
            _type="${1}"
            case "${_type}" in
            ## (progn (forward-line 1) (snip-insert "sh_b.case_patterns_for_actions" t t "sh" " --key actions --value '::fillme::'") (insert ""))
            v|vi|vie|view) _type='svg';;
            esac
            if test -z "${_type}"
            then
                cat
            else
                plantuml -t"${_type}" -pipe
            fi
        }
        out_filt_disp ()
        {
            _type="${1}"
            case "${_type}" in
            ## (progn (forward-line 1) (snip-insert "sh_b.case_patterns_for_actions" t t "sh" " --key actions --value '::fillme::'") (insert ""))
            v|vi|vie|view) _type='view';;
            esac
            if test "${_type}" != view
            then
                cat
            else
                display
            fi
        }
        (
        if test -n "${opt_umlx_match}"
        then
            line_diversion.py --match "${opt_umlx_match}" "${prog_path-${0}}"
        else
            line_diversion.py "${prog_path-${0}}"
        fi
        ) \
        | out_filt_conv "${opt_umlx_type}" \
        | out_filt_disp "${opt_umlx_type}"
        exit 0
        #pass_opts="${pass_opts}"' --umlx '"${opt_umlx}"
        #pass_opts="${pass_opts}"' --umlx '"$( single_quote_enclose "${opt_umlx}" )
        ;;
    --) # end of options
        shift; break;;
    -) # stdin
        break;;
    -*) # unknown option
        printf >&2 "%s: error: unknown option \`%s'\n" "${prog_name-$( basename "${0}" )}" "${1}"
        exit 1
        break
        ;;
    *)
        break;;
    esac
    shift
done

ECHO=
pecho () { printf "%s\n" "${*}"; }
test ${opt_debug} = 0 || ECHO=pecho
test ${opt_debug} = 0 || opt_verbose=1
_vaq=pecho _valq=pecho
varg_quoter_setup 2>/dev/null || test 1 = 1
test -z "${ECHO}" || test x"${config_log+set}" != xset || printf >&2 "%s\n" "${config_log}"

## (progn (forward-line 1) (snip-insert "sh_b.need_root_have_apt" t t "sh") (insert "\n"))

# ==================================================
# |||:sec:||| MAIN
# ==================================================

## |:sec:| setup #ccccee                                              #a0 :;

# |:here:|

if test ${opt_development} = 1
then
    build_type='Debug'
elif test ${opt_release} = 1
then
    build_type='Release'
else
    printf >&2 "# ||"":ERR:|| error: build type not specified%s\n" ""
    exit 1
fi

GCC="$( which gcc )"
CLANG="$( which clang )"

if test -n "${CLANG}"
then
    export CMAKE_C_COMPILER="${CLANG}"
elif test -n "${GCC}"
then
    export CMAKE_C_COMPILER="${GCC}"
else
    printf >&2 "# ||"":ERR:|| error: no C-Compiler found%s\n" ""
    exit 1
fi

## (progn (forward-line 1) (snip-insert "sh_b.action-loop" t t "sh" " --key skip_for_update --key uml_indx --value 500 --key cmd_action_helpx --value '@action@'") (insert "\n"))

## |:sec:| process stuff #ccccee                                      #a0 :;

## (progn (forward-line 1) (snip-insert "gen_uml.list"                   t t "sh" " --key uml_list --value 'top|ctl|snp|all'") (insert "\n"))
## (progn (forward-line 1) (snip-insert "sh_step.switch" t t "sh" " --key skip_for_update") (insert "\n"))
## (progn (forward-line 1) (snip-insert "sh_cmd.loop" t t "sh" " --key skip_for_update --key cmd_loop_docx") (insert ""))
## (progn (forward-line 1) (snip-insert "sh_b.async_remote_script" t t "sh" " --key skip_for_update") (insert ""))
## (progn (forward-line 1) (snip-insert "sh_b.wrf-loop" t t "sh" " --key skip_for_update") (insert "\n"))

${ECHO} cd "${prog_dir}" || exit 1
${ECHO} cmake -G "Unix Makefiles" -S . -B build -DCMAKE_BUILD_TYPE="${build_type}"
${ECHO} cd build
${ECHO} make ${1+"$@"}

## } /' move after `stop`, if there are no subsections '/             #a0
## stop                                                               #a0
exit # |||:here:|||

## (progn (forward-line 1) (snip-insert "sh_t.ide" t t "sh" " --key skip_for_update") (insert ""))
#
# :ide-menu: Emacs IDE Main Menu - Buffer @BUFFER@
# . M-x `eIDE-menu' (eIDE-menu "z")
#  (progn (forward-line 1) (snip-insert "gen_ide.uml-extract" t t "sh") (insert "\n"))

# :ide: MENU-OUTLINE:  Sections `||: sec :||'
# . (x-eIDE-menu-outline "sec" '("||:" ":||") '("|:" ":|"))

# :ide: OCCUR-OUTLINE: Sections: `||: sec :||'
# . (x-symbol-tag-occur-outline "sec" '("||:" ":||") '("|:" ":|"))

# :ide: +-
# . Buffer Outline Sections ()

# :ide: CODE: insert case patterns for actions
# . (snip-insert "sh_b.case_patterns_for_actions" t t "sh" (concat " --key actions --value '" (read-from-minibuffer "actions: ") "'"))

# :ide: REGION: Process with fmt_tables --border bar_outer --width 72
# . (shell-command-on-region (region-beginning) (region-end) (concat "fmt_tables.py --width 72 --border bar_outer "))

# :ide: REGION: Process with fmt_tables --border bar_outer --width 66
# . (shell-command-on-region (region-beginning) (region-end) (concat "fmt_tables.py --width 66 --border bar_outer "))

# :ide: REGION: Process with fmt_tables --border bar_outer --width  0
# . (shell-command-on-region (region-beginning) (region-end) (concat "fmt_tables.py --width  0 --border bar_outer "))

# :ide: REGION: Replace with fmt_tables --border bar_outer --width 72 / comment / annotate
# . (shell-command-on-region (region-beginning) (region-end) (concat "sed 's,^ *# *,,;s, *#[copduasmt][0-9]\\+ *[:;|.]*,,' | fmt_tables.py --width 72 --border bar_outer | sed 's,^,#   ,;s,$, #" "a0,' ") nil t)

# :ide: REGION: Replace with fmt_tables --border bar_outer --width 66 / comment / annotate
# . (shell-command-on-region (region-beginning) (region-end) (concat "sed 's,^ *# *,,;s, *#[copduasmt][0-9]\\+ *[:;|.]*,,' | fmt_tables.py --width 66 --border bar_outer | sed 's,^,#   ,;s,$, #" "a0,' ") nil t)

# :ide: REGION: Replace with fmt_tables --border bar_outer --width  0 / comment / annotate
# . (shell-command-on-region (region-beginning) (region-end) (concat "sed 's,^ *# *,,;s, *#[copduasmt][0-9]\\+ *[:;|.]*,,' | fmt_tables.py --width  0 --border bar_outer | sed 's,^,#   ,;s,$, #" "a0,' ") nil t)

# :ide: REGION: Convert variable assignments and insert fmt_tables --border bar_outer --width  0  / comment / annotate :;
# . (let ((b (region-beginning)) (e (region-end))) (goto-char b) (shell-command-on-region b e (concat "( printf '%s\\n' '| **variable** | **value** |'; ${SED__PROG-sed} '/^ *#/d;/^ *$/d;s,^,| ,;s,=['\\''\"]\\?, | ,;s,\\( *['\\''\"]\\?\\)$, |,' ) | fmt_tables.py --width  0 --border bar_outer | ${SED__PROG-sed} 's,^,# ,;s,$, #" "a0 .,;1s,.$,:,;$s,[.]\\?$,;,'") t nil nil t))

# :ide: +-
# . Utilities ()

# :ide: SHELL: (the good old simple elisp version) Run w/o args
# . (progn (save-buffer) (shell-command (concat "sh " (shell-quote-argument (buffer-file-name)) " ") nil))

# :ide: SHELL: Run with (args: "") (setup commands: "") (how: [s] synchronously, [a] asynchronously, [c] compile or [g] grep) with output (out: [s] to *Shell Command Output)*, [p] at point in current buffer, [b] to own temporary buffer)
# . (let* ((args "") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: +-
# . HOW TO ()

# :ide: UML: Run with --umlx a0:view
# . (progn (save-buffer) (shell-command (concat "sh " (shell-quote-argument (buffer-file-name)) " --umlx '^a0$:view'")))

# :ide: SHELL: Run with --help
# . (progn (save-buffer) (shell-command (concat "sh " (shell-quote-argument (buffer-file-name)) " --help")))

# :ide: #
# . ()

# :ide: SHELL: Run with/out arguments # output in separate buffer *@BUFFER@*
# . (let* ((args "") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (b s p))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: ASYNC: Run with/out arguments
# . (let* ((args "") (cmd nil) (setup "sh ") (how (quote (a c g s))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: SHELL: Run with/out arguments # insert output at point
# . (let* ((args "") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (p b s))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: #
# . ()

## (snip-expand (forward-line 1) (snip-insert "gen_ide.shell-async-comp-grep" t t "sh" " --key skip_for_update --undef sacg-args  --undef sacg-args-descr --undef sacg-cmd --undef sacg-cmd-descr --undef sacg-setup --undef sacg-how --undef sacg-how-descr --undef sacg-out") (insert ""))
# :ide: SHELL: Run with/out arguments
# . (let* ((args "") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))
# :ide: SHELL: Run with/out arguments
# . (let* ((args "") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: SHELL: Run with/out arguments
# . (let* ((args "") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: SHELL: Run with --development
# . (let* ((args "--development") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: SHELL: Run with # --release
# . (let* ((args "") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: SHELL: Run with --debug --development
# . (let* ((args "--debug --development") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

# :ide: SHELL: Run with --debug # --release
# . (let* ((args "--debug") (cmd nil) (setup "sh ") (how (quote (s a c g))) (out (quote (s p b))) (f (or (buffer-file-name) "/dev/null")) (b (file-name-nondirectory f)) (n (buffer-name)) (o (cond ((eq (car out) (quote b)) (concat "*" n "*")) ((eq (car how) (quote c)) nil) ((eq (car how) (quote g)) nil) ((eq (car out) (quote p)) t) (t (and (boundp (quote eIDE-current-prefix-arg)) eIDE-current-prefix-arg))))) (and (buffer-file-name) (save-buffer)) (funcall (cond ((eq (car how) (quote a)) (quote async-shell-command)) ((eq (car how) (quote c)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (compile c))))) ((eq (car how) (quote g)) (function (lambda (c o) (let ((compilation-buffer-name-function (function (lambda (&optional name-of-mode) (concat o name-of-mode "*"))))) (grep c))))) (t (quote shell-command))) (concat setup (shell-quote-argument (or cmd f)) " " args) o))

## (snip-expand (forward-line 1) (snip-insert "sh_step.ide" t t "sh" " --key skip_for_update") (insert "\n"))

#
# Local Variables:
# mode: sh
# comment-start: "#"
# comment-start-skip: "#+"
# comment-column: 0
# truncate-lines: t
# End:
# mmm-classes: (workspace here-doc eIDE)
