*&---------------------------------------------------------------------*
*&  Include           ZAL13_TESTE_BDL_TOP
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*** Declaration of Infotypes
*&---------------------------------------------------------------------*
INFOTYPES: 0002,
           0006.

*&---------------------------------------------------------------------*
*** Declaration of Tables
*&---------------------------------------------------------------------*
TABLES: pernr.

*&---------------------------------------------------------------------*
*** Declaration of types
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_report,
         pernr TYPE pa0002-pernr,
         cname TYPE pa0002-cname,
         stras TYPE pa0006-stras,
       END OF ty_report.

*&---------------------------------------------------------------------*
*** Declaration of global Internal Tables
*&---------------------------------------------------------------------*
DATA gt_report TYPE TABLE OF ty_report.

*&---------------------------------------------------------------------*
*** Declaration of global work areas
*&---------------------------------------------------------------------*
DATA gwa_report TYPE ty_report.

*&---------------------------------------------------------------------*
*&  Alv Structures                                                  *
*&---------------------------------------------------------------------*
DATA:  vg_nrcol(4) TYPE c.

DATA: ty_layout       TYPE slis_layout_alv,
      ty_top          TYPE slis_t_listheader,
      ty_watop        TYPE slis_listheader,
      ty_fieldcat_col TYPE slis_t_fieldcat_alv,
      ty_fieldcat     TYPE slis_fieldcat_alv,
      ty_events       TYPE slis_t_event.

DATA : sch_repid TYPE sy-repid,
       sch_dynnr TYPE sy-dynnr,
       sch_field TYPE dynpread-fieldname,
       sch_objec TYPE objec,
       sch_subrc TYPE sy-subrc,
       per_beg   TYPE sy-datum,
       per_end   TYPE sy-datum.

TABLES hrvpv6a.
