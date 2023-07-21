*======================================================================*
*                                                                      *
*                                HRST                                  *
*                                                                      *
*======================================================================*
* Author      : Fábrica ABAP                                           *
* Analist     : Vinicius Moura                                         *
* Date        : 29/06/2023                                             *
*----------------------------------------------------------------------*
* Project     : Projeto HRST                                           *
* Report      : ZAL13_TESTE_BDL                                        *
* Finality    :                                                        *
*----------------------------------------------------------------------*
* Changes History                                                      *
*----------------------------------------------------------------------*
* Date       | Author         | Finality                               *
* 29/06/2023 | VMOURA         |                                        *
*======================================================================*
REPORT zal13_teste_bdl.

INCLUDE: zal13_teste_bdl_top,
         zal13_teste_bdl_f01.

START-OF-SELECTION.
  GET pernr.
  PERFORM f_get_data.

END-OF-SELECTION.
  PERFORM f_print_alv.
