*&---------------------------------------------------------------------*
*&  Include           ZAL13_TESTE_BDL_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  F_GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_get_data.

  CLEAR gwa_report.
  gwa_report-pernr = p0002-pernr.
  gwa_report-cname = p0002-cname.
  gwa_report-stras = p0006-stras.
  APPEND gwa_report TO gt_report.

ENDFORM.

*&---------------------------------------------------------------------*
*&      FORM  F_PRINT_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_print_alv.

  PERFORM f_header.
  PERFORM f_set_layout.
  PERFORM set_field.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout              = ty_layout           "Estrutura com detalhes do layout.
      i_callback_top_of_page = 'F_TOP_PAGE'          "Estrutura para montar o cabeçalho
      i_callback_program     = sy-repid            "variável do sistema (nome do programa). 'Sy-repid' = 'zcurso_alv1'
*     I_CALLBACK_USER_COMMAND = 'F_USER_COMMAND'    "Chama a função "HOTSPOT"
      i_save                 = 'A'                 "layouts podem ser salvos (aparece os botões para alteração do layout).
*     it_sort                = t_sort[]             "Efetua a quebra com o parametro determinado.
      it_fieldcat            = ty_fieldcat_col     "tabela com as colunas a serem impressas.
    TABLES
      t_outtab               = gt_report.          "Tabela com os dados a serem impressos.

ENDFORM.

*&---------------------------------------------------------------------*
*&      FORM  F_HEADER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_header .

  DATA: vl_data(10),
        vl_hora(10).

  CLEAR ty_watop.
  ty_watop-typ  = 'H'.    "H = Grande, destaque | S = Pequena | A = Média com itálico
  ty_watop-info = TEXT-m01.

  APPEND ty_watop TO ty_top.

  CLEAR ty_watop.

  ty_watop-typ  = 'S'.
  CONCATENATE TEXT-m02 sy-uname
    INTO ty_watop-info
      SEPARATED BY space.

  APPEND ty_watop TO ty_top.

  CLEAR ty_watop.

  ty_watop-typ  = 'S'.

  WRITE sy-datum TO vl_data USING EDIT MASK '__/__/____'.
  WRITE sy-uzeit TO vl_hora USING EDIT MASK '__:__'.

  CONCATENATE TEXT-m03 vl_data  vl_hora
    INTO ty_watop-info
      SEPARATED BY space.

  APPEND ty_watop TO ty_top.

ENDFORM.                    " f_header

*&**********************************************************************
*&      FORM  F_TOP_PAGE                                               *
*&**********************************************************************
*       Defines the header of the ALV
*----------------------------------------------------------------------*
FORM f_top_page.
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = ty_top.
*      I_LOGO             = ''.

ENDFORM.                    "f_top_page

*&---------------------------------------------------------------------*
*&      FORM  F_SET_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_set_layout .
  ty_layout-zebra             = 'X'.                            "Zebrado
  ty_layout-colwidth_optimize = 'X'.                            "Otimizar larguras de colunas automaticamente
ENDFORM.                    " F_SET_LAYOUT

*&---------------------------------------------------------------------*
*&      FORM  F_SET_FIELD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_field .
  "CLEAR IT_HRP1000.

  PERFORM f_set_column USING  'PERNR'         'GT_REPORT' TEXT-t01      ' '  ' '  '12'  ' '  'L'  ' ' ' '.
  PERFORM f_set_column USING  'CNAME'         'GT_REPORT' TEXT-t02      ' '  ' '  '80'  ' '  'L'  ' ' ' '.
  PERFORM f_set_column USING  'STRAS'         'GT_REPORT' TEXT-t03      ' '  ' '  '20'  ' '  'L'  ' ' ' '.

ENDFORM.                    "F_SET_FIELD

*&---------------------------------------------------------------------*
*&       FORM f_set_column                                             *
*----------------------------------------------------------------------*
*        Clears all tables and variables.
*----------------------------------------------------------------------*
FORM f_set_column USING p_fieldname
                        p_tabname
                        p_texto
                        p_ref_fieldname
                        p_ref_tabname
                        p_outputlen
                        p_emphasize
                        p_just
                        p_do_sum
                        p_icon.

  ADD 1 TO vg_nrcol.
  ty_fieldcat-col_pos       = vg_nrcol.            "POSIÇÃO DO CAMPO (COLUNA).
  ty_fieldcat-fieldname     = p_fieldname.         "CAMPO DA TABELA INTERNA.
  ty_fieldcat-tabname       = p_tabname.           "TABELA INTERNA.
  ty_fieldcat-seltext_l     = p_texto.             "NOME/TEXTO DA COLUNA.
  ty_fieldcat-ref_fieldname = p_ref_fieldname.     "CAMPO DE REFERÊNCIA.
  ty_fieldcat-ref_tabname   = p_ref_tabname.       "TABELA DE REFERÊNCIA.
  ty_fieldcat-outputlen     = p_outputlen.         "LARGURA DA COLUNA.
  ty_fieldcat-emphasize     = p_emphasize.         "COLORE UMA COLUNA INTEIRA.
  ty_fieldcat-just          = p_just.              "
  ty_fieldcat-do_sum        = p_do_sum.            "TOTALIZA.
  ty_fieldcat-icon          = p_icon.

  APPEND ty_fieldcat TO ty_fieldcat_col.           "Insere linha na tabela interna TY_FIELDCAT_COL.

ENDFORM.                    "f_set_column
