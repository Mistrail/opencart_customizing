<?php
/*
@author	Dmitriy Kubarev
@link	http://www.simpleopencart.com
@link	http://www.opencart.com/index.php?route=extension/extension/info&extension_id=4811
*/  

class ControllerModuleSimple extends Controller {
	private $error = array(); 
	
    public function install() {
        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting('simple', unserialize(base64_decode('YTo4Mzp7czoxNDoic2ltcGxlX2FjZXNob3AiO3M6MDoiIjtzOjM4OiJzaW1wbGVfcmVnaXN0cmF0aW9uX3ZpZXdfY3VzdG9tZXJfdHlwZSI7czoxOiIwIjtzOjM0OiJzaW1wbGVfcmVnaXN0cmF0aW9uX3N1YnNjcmliZV9pbml0IjtzOjE6IjEiO3M6Mjk6InNpbXBsZV9yZWdpc3RyYXRpb25fc3Vic2NyaWJlIjtzOjE6IjIiO3M6Mjc6InNpbXBsZV9yZWdpc3RyYXRpb25fY2FwdGNoYSI7czoxOiIwIjtzOjE4OiJzaW1wbGVfdXNlX2Nvb2tpZXMiO3M6MToiMCI7czoyOToic2ltcGxlX2Rpc2FibGVfZ3Vlc3RfY2hlY2tvdXQiO3M6MToiMCI7czo0Mzoic2ltcGxlX3JlZ2lzdHJhdGlvbl9hZ3JlZW1lbnRfY2hlY2tib3hfaW5pdCI7czoxOiIwIjtzOjM4OiJzaW1wbGVfcmVnaXN0cmF0aW9uX2FncmVlbWVudF9jaGVja2JveCI7czoxOiIxIjtzOjMwOiJzaW1wbGVfc2hvd193aWxsX2JlX3JlZ2lzdGVyZWQiO3M6MToiMSI7czoyNDoic2ltcGxlX2ZpZWxkc19mb3JfcmVsb2FkIjtzOjY3OiJtYWluX2NvdW50cnlfaWQsbWFpbl96b25lX2lkLG1haW5fY2l0eSxtYWluX3Bvc3Rjb2RlLG1haW5fYWRkcmVzc18xIjtpOjA7YToxOntzOjEyOiJjb21wYW55X25hbWUiO2E6MTY6e3M6MjoiaWQiO3M6MTI6ImNvbXBhbnlfbmFtZSI7czo1OiJsYWJlbCI7YToyOntzOjI6InJ1IjtzOjMzOiLQndCw0LfQstCw0L3QuNC1INC60L7QvNC/0LDQvdC40LgiO3M6MjoiZW4iO3M6MTI6IkNvbXBhbnkgTmFtZSI7fXM6NDoidHlwZSI7czo0OiJ0ZXh0IjtzOjY6InZhbHVlcyI7YToyOntzOjI6InJ1IjtzOjA6IiI7czoyOiJlbiI7czowOiIiO31zOjg6ImRhdGVfbWluIjtzOjA6IiI7czoxMDoiZGF0ZV9zdGFydCI7czowOiIiO3M6ODoiZGF0ZV9tYXgiO3M6MDoiIjtzOjg6ImRhdGVfZW5kIjtzOjA6IiI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWluIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjM6IjEyOCI7czoxNzoidmFsaWRhdGlvbl9yZWdleHAiO3M6MDoiIjtzOjE2OiJ2YWxpZGF0aW9uX2Vycm9yIjthOjI6e3M6MjoicnUiO3M6ODg6ItCd0LDQt9Cy0LDQvdC40LUg0LrQvtC80L/QsNC90LjQuCDQtNC+0LvQttC90L4g0LHRi9GC0Ywg0L7RgiAyINC00L4gMTI4INGB0LjQvNCy0L7Qu9C+0LIiO3M6MjoiZW4iO3M6NDk6IkNvbXBhbnkgTmFtZSBtdXN0IGJlIGJldHdlZW4gMiBhbmQgMTI4IGNoYXJhY3RlcnMiO31zOjc6InNhdmVfdG8iO3M6NzoiY29tbWVudCI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fX1zOjMyOiJzaW1wbGVfcmVnaXN0cmF0aW9uX2FncmVlbWVudF9pZCI7czoxOiIwIjtzOjM5OiJzaW1wbGVfcmVnaXN0cmF0aW9uX3Bhc3N3b3JkX2xlbmd0aF9tYXgiO3M6MjoiMjAiO3M6Mzk6InNpbXBsZV9yZWdpc3RyYXRpb25fcGFzc3dvcmRfbGVuZ3RoX21pbiI7czoxOiI0IjtzOjM2OiJzaW1wbGVfcmVnaXN0cmF0aW9uX3Bhc3N3b3JkX2NvbmZpcm0iO3M6MToiMCI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjAiO3M6Mzc6InNpbXBsZV9yZWdpc3RyYXRpb25fZ2VuZXJhdGVfcGFzc3dvcmQiO3M6MToiMCI7czoxNDoicGxhY2Vob2xkZXJfZW4iO3M6MDoiIjtzOjQ6Im1hc2siO3M6MDoiIjtzOjE0OiJwbGFjZWhvbGRlcl9ydSI7czowOiIiO3M6Nzoic2F2ZV90byI7czo3OiJjb21tZW50IjtzOjE5OiJ2YWxpZGF0aW9uX2Vycm9yX2VuIjtzOjA6IiI7czoxOToidmFsaWRhdGlvbl9lcnJvcl9ydSI7czowOiIiO3M6MTc6InZhbGlkYXRpb25fcmVnZXhwIjtzOjA6IiI7czoxNDoidmFsaWRhdGlvbl9tYXgiO3M6MDoiIjtzOjE0OiJ2YWxpZGF0aW9uX21pbiI7czowOiIiO3M6OToidmFsdWVzX2VuIjtzOjA6IiI7czoyNjoic2hpcHBpbmdfY29kZV9mb3Jfc2hpcHBpbmciO3M6MDoiIjtzOjMxOiJzaW1wbGVfY3VzdG9tZXJfZmllbGRzX3NldHRpbmdzIjthOjE2OntzOjEwOiJtYWluX2VtYWlsIjthOjExOntzOjI6ImlkIjtzOjEwOiJtYWluX2VtYWlsIjtzOjU6ImxhYmVsIjthOjI6e3M6MjoicnUiO3M6NjoiRS1tYWlsIjtzOjI6ImVuIjtzOjY6IkUtbWFpbCI7fXM6NDoidHlwZSI7czo0OiJ0ZXh0IjtzOjY6InZhbHVlcyI7czowOiIiO3M6NDoiaW5pdCI7czowOiIiO3M6MTU6InZhbGlkYXRpb25fdHlwZSI7czoxOiIzIjtzOjE3OiJ2YWxpZGF0aW9uX3JlZ2V4cCI7czoyNjoiL15bXlxAXStALipcLlthLXpdezIsNn0kL2kiO3M6MTY6InZhbGlkYXRpb25fZXJyb3IiO2E6Mjp7czoyOiJydSI7czo2Mjoi0J7RiNC40LHQutCwINCyINCw0LTRgNC10YHQtSDRjdC70LXQutGC0YDQvtC90L3QvtC5INC/0L7Rh9GC0YsiO3M6MjoiZW4iO3M6NDM6IkUtTWFpbCBBZGRyZXNzIGRvZXMgbm90IGFwcGVhciB0byBiZSB2YWxpZCEiO31zOjc6InNhdmVfdG8iO3M6NToiZW1haWwiO3M6NDoibWFzayI7czowOiIiO3M6MTE6InBsYWNlaG9sZGVyIjthOjI6e3M6MjoicnUiO3M6MDoiIjtzOjI6ImVuIjtzOjA6IiI7fX1zOjE0OiJtYWluX2ZpcnN0bmFtZSI7YToxMzp7czoyOiJpZCI7czoxNDoibWFpbl9maXJzdG5hbWUiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czo2OiLQmNC80Y8iO3M6MjoiZW4iO3M6MTA6IkZpcnN0IE5hbWUiO31zOjQ6InR5cGUiO3M6NDoidGV4dCI7czo2OiJ2YWx1ZXMiO3M6MDoiIjtzOjQ6ImluaXQiO3M6MDoiIjtzOjE1OiJ2YWxpZGF0aW9uX3R5cGUiO3M6MToiMiI7czoxNDoidmFsaWRhdGlvbl9taW4iO3M6MToiMSI7czoxNDoidmFsaWRhdGlvbl9tYXgiO3M6MjoiMzAiO3M6MTc6InZhbGlkYXRpb25fcmVnZXhwIjtzOjA6IiI7czoxNjoidmFsaWRhdGlvbl9lcnJvciI7YToyOntzOjI6InJ1IjtzOjYwOiLQmNC80Y8g0LTQvtC70LbQvdC+INCx0YvRgtGMINC+0YIgMSDQtNC+IDMwINGB0LjQvNCy0L7Qu9C+0LIiO3M6MjoiZW4iO3M6NDc6IkZpcnN0IE5hbWUgbXVzdCBiZSBiZXR3ZWVuIDEgYW5kIDMyIGNoYXJhY3RlcnMhIjt9czo3OiJzYXZlX3RvIjtzOjk6ImZpcnN0bmFtZSI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fXM6MTM6Im1haW5fbGFzdG5hbWUiO2E6MTM6e3M6MjoiaWQiO3M6MTM6Im1haW5fbGFzdG5hbWUiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czoxNDoi0KTQsNC80LjQu9C40Y8iO3M6MjoiZW4iO3M6OToiTGFzdCBOYW1lIjt9czo0OiJ0eXBlIjtzOjQ6InRleHQiO3M6NjoidmFsdWVzIjtzOjA6IiI7czo0OiJpbml0IjtzOjA6IiI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWluIjtzOjE6IjEiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjI6IjMwIjtzOjE3OiJ2YWxpZGF0aW9uX3JlZ2V4cCI7czowOiIiO3M6MTY6InZhbGlkYXRpb25fZXJyb3IiO2E6Mjp7czoyOiJydSI7czo2ODoi0KTQsNC80LjQu9C40Y8g0LTQvtC70LbQvdC+INCx0YvRgtGMINC+0YIgMSDQtNC+IDMwINGB0LjQvNCy0L7Qu9C+0LIiO3M6MjoiZW4iO3M6NDY6Ikxhc3QgTmFtZSBtdXN0IGJlIGJldHdlZW4gMSBhbmQgMzIgY2hhcmFjdGVycyEiO31zOjc6InNhdmVfdG8iO3M6ODoibGFzdG5hbWUiO3M6NDoibWFzayI7czowOiIiO3M6MTE6InBsYWNlaG9sZGVyIjthOjI6e3M6MjoicnUiO3M6MDoiIjtzOjI6ImVuIjtzOjA6IiI7fX1zOjE0OiJtYWluX3RlbGVwaG9uZSI7YToxMzp7czoyOiJpZCI7czoxNDoibWFpbl90ZWxlcGhvbmUiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czoxNDoi0KLQtdC70LXRhNC+0L0iO3M6MjoiZW4iO3M6OToiVGVsZXBob25lIjt9czo0OiJ0eXBlIjtzOjQ6InRleHQiO3M6NjoidmFsdWVzIjtzOjA6IiI7czo0OiJpbml0IjtzOjA6IiI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWluIjtzOjE6IjMiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjI6IjMyIjtzOjE3OiJ2YWxpZGF0aW9uX3JlZ2V4cCI7czowOiIiO3M6MTY6InZhbGlkYXRpb25fZXJyb3IiO2E6Mjp7czoyOiJydSI7czo2OToi0KLQtdC70LXRhNC+0L0g0LTQvtC70LbQtdC9INCx0YvRgtGMINC+0YIgMyDQtNC+IDMyINGB0LjQvNCy0L7Qu9C+0LIhIjtzOjI6ImVuIjtzOjQ2OiJUZWxlcGhvbmUgbXVzdCBiZSBiZXR3ZWVuIDMgYW5kIDMyIGNoYXJhY3RlcnMhIjt9czo3OiJzYXZlX3RvIjtzOjk6InRlbGVwaG9uZSI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fXM6ODoibWFpbl9mYXgiO2E6MTM6e3M6MjoiaWQiO3M6ODoibWFpbl9mYXgiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czo4OiLQpNCw0LrRgSI7czoyOiJlbiI7czozOiJGYXgiO31zOjQ6InR5cGUiO3M6NDoidGV4dCI7czo2OiJ2YWx1ZXMiO3M6MDoiIjtzOjQ6ImluaXQiO3M6MDoiIjtzOjE1OiJ2YWxpZGF0aW9uX3R5cGUiO3M6MToiMCI7czoxNDoidmFsaWRhdGlvbl9taW4iO3M6MDoiIjtzOjE0OiJ2YWxpZGF0aW9uX21heCI7czowOiIiO3M6MTc6InZhbGlkYXRpb25fcmVnZXhwIjtzOjA6IiI7czoxNjoidmFsaWRhdGlvbl9lcnJvciI7YToyOntzOjI6InJ1IjtzOjA6IiI7czoyOiJlbiI7czowOiIiO31zOjc6InNhdmVfdG8iO3M6MzoiZmF4IjtzOjQ6Im1hc2siO3M6MDoiIjtzOjExOiJwbGFjZWhvbGRlciI7YToyOntzOjI6InJ1IjtzOjA6IiI7czoyOiJlbiI7czowOiIiO319czoyMjoibWFpbl9jdXN0b21lcl9ncm91cF9pZCI7YToxMzp7czoyOiJpZCI7czoyMjoibWFpbl9jdXN0b21lcl9ncm91cF9pZCI7czo1OiJsYWJlbCI7YToyOntzOjI6InJ1IjtzOjMzOiLQk9GA0YPQv9C/0LAg0L/QvtC60YPQv9Cw0YLQtdC70Y8iO3M6MjoiZW4iO3M6MTQ6IkN1c3RvbWVyIGdyb3VwIjt9czo0OiJ0eXBlIjtzOjY6InNlbGVjdCI7czo2OiJ2YWx1ZXMiO3M6NjoiZ3JvdXBzIjtzOjQ6ImluaXQiO3M6MDoiIjtzOjE0OiJ2YWxpZGF0aW9uX21pbiI7czowOiIiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjA6IiI7czoxNzoidmFsaWRhdGlvbl9yZWdleHAiO3M6MDoiIjtzOjE1OiJ2YWxpZGF0aW9uX3R5cGUiO3M6MToiNCI7czoxNjoidmFsaWRhdGlvbl9lcnJvciI7YToyOntzOjI6InJ1IjtzOjcxOiLQn9C+0LbQsNC70YPQudGB0YLQsCDQstGL0LHQtdGA0LjRgtC1INCz0YDRg9C/0L/RgyDQv9C+0LrRg9C/0LDRgtC10LvRjyI7czoyOiJlbiI7czozMDoiUGxlYXNlIHNlbGVjdCBhIGN1c3RvbWVyIGdyb3VwIjt9czo3OiJzYXZlX3RvIjtzOjE3OiJjdXN0b21lcl9ncm91cF9pZCI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fXM6MTI6Im1haW5fY29tcGFueSI7YToxMzp7czoyOiJpZCI7czoxMjoibWFpbl9jb21wYW55IjtzOjU6ImxhYmVsIjthOjI6e3M6MjoicnUiO3M6MTY6ItCa0L7QvNC/0LDQvdC40Y8iO3M6MjoiZW4iO3M6NzoiQ29tcGFueSI7fXM6NDoidHlwZSI7czo0OiJ0ZXh0IjtzOjY6InZhbHVlcyI7czowOiIiO3M6NDoiaW5pdCI7czowOiIiO3M6MTU6InZhbGlkYXRpb25fdHlwZSI7czoxOiIwIjtzOjE0OiJ2YWxpZGF0aW9uX21pbiI7czowOiIiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjA6IiI7czoxNzoidmFsaWRhdGlvbl9yZWdleHAiO3M6MDoiIjtzOjE2OiJ2YWxpZGF0aW9uX2Vycm9yIjthOjI6e3M6MjoicnUiO3M6MDoiIjtzOjI6ImVuIjtzOjA6IiI7fXM6Nzoic2F2ZV90byI7czo3OiJjb21wYW55IjtzOjQ6Im1hc2siO3M6MDoiIjtzOjExOiJwbGFjZWhvbGRlciI7YToyOntzOjI6InJ1IjtzOjA6IiI7czoyOiJlbiI7czowOiIiO319czoxNToibWFpbl9jb21wYW55X2lkIjthOjEzOntzOjI6ImlkIjtzOjE1OiJtYWluX2NvbXBhbnlfaWQiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czoxMDoiQ29tcGFueSBJRCI7czoyOiJlbiI7czoxMDoiQ29tcGFueSBJRCI7fXM6NDoidHlwZSI7czo0OiJ0ZXh0IjtzOjY6InZhbHVlcyI7czowOiIiO3M6NDoiaW5pdCI7czowOiIiO3M6MTU6InZhbGlkYXRpb25fdHlwZSI7czoxOiIwIjtzOjE0OiJ2YWxpZGF0aW9uX21pbiI7czowOiIiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjA6IiI7czoxNzoidmFsaWRhdGlvbl9yZWdleHAiO3M6MDoiIjtzOjE2OiJ2YWxpZGF0aW9uX2Vycm9yIjthOjI6e3M6MjoicnUiO3M6MDoiIjtzOjI6ImVuIjtzOjA6IiI7fXM6Nzoic2F2ZV90byI7czoxMDoiY29tcGFueV9pZCI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fXM6MTE6Im1haW5fdGF4X2lkIjthOjEzOntzOjI6ImlkIjtzOjExOiJtYWluX3RheF9pZCI7czo1OiJsYWJlbCI7YToyOntzOjI6InJ1IjtzOjY6IlRheCBJRCI7czoyOiJlbiI7czo2OiJUYXggSUQiO31zOjQ6InR5cGUiO3M6NDoidGV4dCI7czo2OiJ2YWx1ZXMiO3M6MDoiIjtzOjQ6ImluaXQiO3M6MDoiIjtzOjE1OiJ2YWxpZGF0aW9uX3R5cGUiO3M6MToiMCI7czoxNDoidmFsaWRhdGlvbl9taW4iO3M6MDoiIjtzOjE0OiJ2YWxpZGF0aW9uX21heCI7czowOiIiO3M6MTc6InZhbGlkYXRpb25fcmVnZXhwIjtzOjA6IiI7czoxNjoidmFsaWRhdGlvbl9lcnJvciI7YToyOntzOjI6InJ1IjtzOjA6IiI7czoyOiJlbiI7czowOiIiO31zOjc6InNhdmVfdG8iO3M6NjoidGF4X2lkIjtzOjQ6Im1hc2siO3M6MDoiIjtzOjExOiJwbGFjZWhvbGRlciI7YToyOntzOjI6InJ1IjtzOjA6IiI7czoyOiJlbiI7czowOiIiO319czoxNDoibWFpbl9hZGRyZXNzXzEiO2E6MTM6e3M6MjoiaWQiO3M6MTQ6Im1haW5fYWRkcmVzc18xIjtzOjU6ImxhYmVsIjthOjI6e3M6MjoicnUiO3M6MTA6ItCQ0LTRgNC10YEiO3M6MjoiZW4iO3M6MTQ6IkFkZHJlc3MgTGluZSAxIjt9czo0OiJ0eXBlIjtzOjQ6InRleHQiO3M6NjoidmFsdWVzIjtzOjA6IiI7czo0OiJpbml0IjtzOjA6IiI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWluIjtzOjE6IjMiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjM6IjEyOCI7czoxNzoidmFsaWRhdGlvbl9yZWdleHAiO3M6MDoiIjtzOjE2OiJ2YWxpZGF0aW9uX2Vycm9yIjthOjI6e3M6MjoicnUiO3M6NjU6ItCQ0LTRgNC10YEg0LTQvtC70LbQtdC9INCx0YvRgtGMINC+0YIgMyDQtNC+IDEyOCDRgdC40LzQstC+0LvQvtCyIjtzOjI6ImVuIjtzOjQ3OiJBZGRyZXNzIDEgbXVzdCBiZSBiZXR3ZWVuIDMgYW5kIDEyOCBjaGFyYWN0ZXJzISI7fXM6Nzoic2F2ZV90byI7czo5OiJhZGRyZXNzXzEiO3M6NDoibWFzayI7czowOiIiO3M6MTE6InBsYWNlaG9sZGVyIjthOjI6e3M6MjoicnUiO3M6MDoiIjtzOjI6ImVuIjtzOjA6IiI7fX1zOjE0OiJtYWluX2FkZHJlc3NfMiI7YToxMzp7czoyOiJpZCI7czoxNDoibWFpbl9hZGRyZXNzXzIiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czozNToi0JDQtNGA0LXRgSAo0L/RgNC+0LTQvtC70LbQtdC90LjQtSkiO3M6MjoiZW4iO3M6MTQ6IkFkZHJlc3MgTGluZSAyIjt9czo0OiJ0eXBlIjtzOjQ6InRleHQiO3M6NjoidmFsdWVzIjtzOjA6IiI7czo0OiJpbml0IjtzOjA6IiI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjAiO3M6MTQ6InZhbGlkYXRpb25fbWluIjtzOjA6IiI7czoxNDoidmFsaWRhdGlvbl9tYXgiO3M6MDoiIjtzOjE3OiJ2YWxpZGF0aW9uX3JlZ2V4cCI7czowOiIiO3M6MTY6InZhbGlkYXRpb25fZXJyb3IiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9czo3OiJzYXZlX3RvIjtzOjk6ImFkZHJlc3NfMiI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fXM6MTM6Im1haW5fcG9zdGNvZGUiO2E6MTM6e3M6MjoiaWQiO3M6MTM6Im1haW5fcG9zdGNvZGUiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czoxMjoi0JjQvdC00LXQutGBIjtzOjI6ImVuIjtzOjg6IlBvc3Rjb2RlIjt9czo0OiJ0eXBlIjtzOjQ6InRleHQiO3M6NjoidmFsdWVzIjtzOjA6IiI7czo0OiJpbml0IjtzOjA6IiI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWluIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjI6IjEwIjtzOjE3OiJ2YWxpZGF0aW9uX3JlZ2V4cCI7czowOiIiO3M6MTY6InZhbGlkYXRpb25fZXJyb3IiO2E6Mjp7czoyOiJydSI7czo4Mzoi0J/QvtGH0YLQvtCy0YvQuSDQuNC90LTQtdC60YEg0LTQvtC70LbQtdC9INCx0YvRgtGMINC+0YIgMiDQtNC+IDEwINGB0LjQvNCy0L7Qu9C+0LIiO3M6MjoiZW4iO3M6NDU6IlBvc3Rjb2RlIG11c3QgYmUgYmV0d2VlbiAyIGFuZCAxMCBjaGFyYWN0ZXJzISI7fXM6Nzoic2F2ZV90byI7czo4OiJwb3N0Y29kZSI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fXM6MTU6Im1haW5fY291bnRyeV9pZCI7YToxMzp7czoyOiJpZCI7czoxNToibWFpbl9jb3VudHJ5X2lkIjtzOjU6ImxhYmVsIjthOjI6e3M6MjoicnUiO3M6MTI6ItCh0YLRgNCw0L3QsCI7czoyOiJlbiI7czo3OiJDb3VudHJ5Ijt9czo0OiJ0eXBlIjtzOjY6InNlbGVjdCI7czo2OiJ2YWx1ZXMiO3M6OToiY291bnRyaWVzIjtzOjQ6ImluaXQiO3M6MToiMCI7czoxNDoidmFsaWRhdGlvbl9taW4iO3M6MDoiIjtzOjE0OiJ2YWxpZGF0aW9uX21heCI7czowOiIiO3M6MTc6InZhbGlkYXRpb25fcmVnZXhwIjtzOjA6IiI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjQiO3M6MTY6InZhbGlkYXRpb25fZXJyb3IiO2E6Mjp7czoyOiJydSI7czo1MDoi0J/QvtC20LDQu9GD0LnRgdGC0LAg0LLRi9Cx0LXRgNC40YLQtSDRgdGC0YDQsNC90YMiO3M6MjoiZW4iO3M6MjM6IlBsZWFzZSBzZWxlY3QgYSBjb3VudHJ5Ijt9czo3OiJzYXZlX3RvIjtzOjEwOiJjb3VudHJ5X2lkIjtzOjQ6Im1hc2siO3M6MDoiIjtzOjExOiJwbGFjZWhvbGRlciI7YToyOntzOjI6InJ1IjtzOjA6IiI7czoyOiJlbiI7czowOiIiO319czoxMjoibWFpbl96b25lX2lkIjthOjEzOntzOjI6ImlkIjtzOjEyOiJtYWluX3pvbmVfaWQiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czoxMjoi0KDQtdCz0LjQvtC9IjtzOjI6ImVuIjtzOjQ6IlpvbmUiO31zOjQ6InR5cGUiO3M6Njoic2VsZWN0IjtzOjY6InZhbHVlcyI7czo1OiJ6b25lcyI7czo0OiJpbml0IjtzOjE6IjAiO3M6MTQ6InZhbGlkYXRpb25fbWluIjtzOjA6IiI7czoxNDoidmFsaWRhdGlvbl9tYXgiO3M6MDoiIjtzOjE3OiJ2YWxpZGF0aW9uX3JlZ2V4cCI7czowOiIiO3M6MTU6InZhbGlkYXRpb25fdHlwZSI7czoxOiI0IjtzOjE2OiJ2YWxpZGF0aW9uX2Vycm9yIjthOjI6e3M6MjoicnUiO3M6NTA6ItCf0L7QttCw0LvRg9C50YHRgtCwINCy0YvQsdC10YDQuNGC0LUg0YDQtdCz0LjQvtC9IjtzOjI6ImVuIjtzOjIyOiJQbGVhc2Ugc2VsZWN0IGEgcmVnaW9uIjt9czo3OiJzYXZlX3RvIjtzOjc6InpvbmVfaWQiO3M6NDoibWFzayI7czowOiIiO3M6MTE6InBsYWNlaG9sZGVyIjthOjI6e3M6MjoicnUiO3M6MDoiIjtzOjI6ImVuIjtzOjA6IiI7fX1zOjk6Im1haW5fY2l0eSI7YToxMzp7czoyOiJpZCI7czo5OiJtYWluX2NpdHkiO3M6NToibGFiZWwiO2E6Mjp7czoyOiJydSI7czoxMDoi0JPQvtGA0L7QtCI7czoyOiJlbiI7czo0OiJDaXR5Ijt9czo0OiJ0eXBlIjtzOjQ6InRleHQiO3M6NjoidmFsdWVzIjtzOjA6IiI7czo0OiJpbml0IjtzOjA6IiI7czoxNToidmFsaWRhdGlvbl90eXBlIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWluIjtzOjE6IjIiO3M6MTQ6InZhbGlkYXRpb25fbWF4IjtzOjM6IjEyOCI7czoxNzoidmFsaWRhdGlvbl9yZWdleHAiO3M6MDoiIjtzOjE2OiJ2YWxpZGF0aW9uX2Vycm9yIjthOjI6e3M6MjoicnUiO3M6NjU6ItCT0L7RgNC+0LQg0LTQvtC70LbQtdC9INCx0YvRgtGMINC+0YIgMiDQtNC+IDEyOCDRgdC40LzQstC+0LvQvtCyIjtzOjI6ImVuIjtzOjQyOiJDaXR5IG11c3QgYmUgYmV0d2VlbiAyIGFuZCAxMjggY2hhcmFjdGVycyEiO31zOjc6InNhdmVfdG8iO3M6NDoiY2l0eSI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fXM6MTI6Im1haW5fY29tbWVudCI7YToxMzp7czoyOiJpZCI7czoxMjoibWFpbl9jb21tZW50IjtzOjU6ImxhYmVsIjthOjI6e3M6MjoicnUiO3M6MjI6ItCa0L7QvNC80LXQvdGC0LDRgNC40LkiO3M6MjoiZW4iO3M6NzoiQ29tbWVudCI7fXM6NDoidHlwZSI7czo4OiJ0ZXh0YXJlYSI7czo2OiJ2YWx1ZXMiO3M6MDoiIjtzOjQ6ImluaXQiO3M6MDoiIjtzOjE1OiJ2YWxpZGF0aW9uX3R5cGUiO3M6MToiMCI7czoxNDoidmFsaWRhdGlvbl9taW4iO3M6MDoiIjtzOjE0OiJ2YWxpZGF0aW9uX21heCI7czowOiIiO3M6MTc6InZhbGlkYXRpb25fcmVnZXhwIjtzOjA6IiI7czoxNjoidmFsaWRhdGlvbl9lcnJvciI7YToyOntzOjI6InJ1IjtzOjA6IiI7czoyOiJlbiI7czowOiIiO31zOjc6InNhdmVfdG8iO3M6NzoiY29tbWVudCI7czo0OiJtYXNrIjtzOjA6IiI7czoxMToicGxhY2Vob2xkZXIiO2E6Mjp7czoyOiJydSI7czowOiIiO3M6MjoiZW4iO3M6MDoiIjt9fX1zOjM1OiJzaW1wbGVfY3VzdG9tZXJfdmlld19hZGRyZXNzX3NlbGVjdCI7czoxOiIxIjtzOjM0OiJzaW1wbGVfY3VzdG9tZXJfdmlld19jdXN0b21lcl90eXBlIjtzOjE6IjAiO3M6MjY6InNpbXBsZV9jdXN0b21lcl9maWVsZHNfc2V0IjthOjI6e3M6NzoiZGVmYXVsdCI7czoxMzU6Im1haW5fZW1haWwsbWFpbl9maXJzdG5hbWUsbWFpbl9sYXN0bmFtZSxtYWluX3RlbGVwaG9uZSxtYWluX2NvdW50cnlfaWQsbWFpbl96b25lX2lkLG1haW5fY2l0eSxtYWluX3Bvc3Rjb2RlLG1haW5fYWRkcmVzc18xLG1haW5fY29tbWVudCI7czoxMjoicmVnaXN0cmF0aW9uIjtzOjEwODoibWFpbl9lbWFpbCxtYWluX2ZpcnN0bmFtZSxtYWluX2xhc3RuYW1lLG1haW5fdGVsZXBob25lLG1haW5fY291bnRyeV9pZCxtYWluX3pvbmVfaWQsbWFpbl9jaXR5LG1haW5fYWRkcmVzc18xIjt9czoyNToic2ltcGxlX2NvbXBhbnlfZmllbGRzX3NldCI7YToyOntzOjc6ImRlZmF1bHQiO3M6MDoiIjtzOjEyOiJyZWdpc3RyYXRpb24iO3M6MDoiIjt9czoyODoic2ltcGxlX3Nob3dfc2hpcHBpbmdfYWRkcmVzcyI7czoxOiIxIjtzOjM1OiJzaW1wbGVfc2hpcHBpbmdfdmlld19hZGRyZXNzX3NlbGVjdCI7czoxOiIxIjtzOjM0OiJzaW1wbGVfc2hpcHBpbmdfYWRkcmVzc19maWVsZHNfc2V0IjthOjE6e3M6NzoiZGVmYXVsdCI7czo5NjoibWFpbl9maXJzdG5hbWUsbWFpbl9sYXN0bmFtZSxtYWluX2NvdW50cnlfaWQsbWFpbl96b25lX2lkLG1haW5fY2l0eSxtYWluX3Bvc3Rjb2RlLG1haW5fYWRkcmVzc18xIjt9czoyOiJpZCI7czowOiIiO3M6ODoibGFiZWxfcnUiO3M6MDoiIjtzOjg6ImxhYmVsX2VuIjtzOjA6IiI7czo0OiJ0eXBlIjtzOjQ6InRleHQiO3M6ODoiZGF0ZV9taW4iO3M6MDoiIjtzOjEwOiJkYXRlX3N0YXJ0IjtzOjA6IiI7czo4OiJkYXRlX21heCI7czowOiIiO3M6ODoiZGF0ZV9lbmQiO3M6MDoiIjtzOjk6InZhbHVlc19ydSI7czowOiIiO3M6MjU6InNoaXBwaW5nX2NvZGVfZm9yX2NvbXBhbnkiO3M6MDoiIjtzOjI2OiJzaGlwcGluZ19jb2RlX2Zvcl9jdXN0b21lciI7czowOiIiO3M6MjY6InNpbXBsZV9jdXN0b21lcl92aWV3X2xvZ2luIjtzOjE6IjEiO3M6NDQ6InNpbXBsZV9jdXN0b21lcl92aWV3X2N1c3RvbWVyX3N1YnNjcmliZV9pbml0IjtzOjE6IjEiO3M6MzI6InNpbXBsZV9jdXN0b21lcl9hY3Rpb25fc3Vic2NyaWJlIjtzOjE6IjIiO3M6NDA6InNpbXBsZV9jdXN0b21lcl92aWV3X3Bhc3N3b3JkX2xlbmd0aF9tYXgiO3M6MjoiMjAiO3M6NDA6InNpbXBsZV9jdXN0b21lcl92aWV3X3Bhc3N3b3JkX2xlbmd0aF9taW4iO3M6MToiNCI7czozNzoic2ltcGxlX2N1c3RvbWVyX3ZpZXdfcGFzc3dvcmRfY29uZmlybSI7czoxOiIwIjtzOjMzOiJzaW1wbGVfY3VzdG9tZXJfZ2VuZXJhdGVfcGFzc3dvcmQiO3M6MToiMCI7czoyNjoic2ltcGxlX2N1c3RvbWVyX3ZpZXdfZW1haWwiO3M6MToiMiI7czo0Mzoic2ltcGxlX2N1c3RvbWVyX3ZpZXdfY3VzdG9tZXJfcmVnaXN0ZXJfaW5pdCI7czoxOiIwIjtzOjMxOiJzaW1wbGVfY3VzdG9tZXJfYWN0aW9uX3JlZ2lzdGVyIjtzOjE6IjIiO3M6MzA6InNpbXBsZV9jdXN0b21lcl9oaWRlX2lmX2xvZ2dlZCI7czoxOiIwIjtzOjM2OiJzaW1wbGVfcGF5bWVudF92aWV3X2F1dG9zZWxlY3RfZmlyc3QiO3M6MToiMCI7czozMzoic2ltcGxlX3BheW1lbnRfdmlld19hZGRyZXNzX2VtcHR5IjtzOjE6IjEiO3M6Mjc6InNpbXBsZV9wYXltZW50X21ldGhvZHNfaGlkZSI7czoxOiIwIjtzOjM3OiJzaW1wbGVfc2hpcHBpbmdfdmlld19hdXRvc2VsZWN0X2ZpcnN0IjtzOjE6IjAiO3M6MzQ6InNpbXBsZV9zaGlwcGluZ192aWV3X2FkZHJlc3NfZW1wdHkiO3M6MToiMSI7czoyNjoic2ltcGxlX3NoaXBwaW5nX3ZpZXdfdGl0bGUiO3M6MToiMSI7czoyODoic2ltcGxlX3NoaXBwaW5nX21ldGhvZHNfaGlkZSI7czoxOiIwIjtzOjI4OiJzaW1wbGVfY29tbW9uX3ZpZXdfaGVscF90ZXh0IjtzOjE6IjAiO3M6MjY6InNpbXBsZV9jb21tb25fdmlld19oZWxwX2lkIjtzOjE6IjAiO3M6NDI6InNpbXBsZV9jb21tb25fdmlld19hZ3JlZW1lbnRfY2hlY2tib3hfaW5pdCI7czoxOiIwIjtzOjM3OiJzaW1wbGVfY29tbW9uX3ZpZXdfYWdyZWVtZW50X2NoZWNrYm94IjtzOjE6IjAiO3M6MzM6InNpbXBsZV9jb21tb25fdmlld19hZ3JlZW1lbnRfdGV4dCI7czoxOiIwIjtzOjMxOiJzaW1wbGVfY29tbW9uX3ZpZXdfYWdyZWVtZW50X2lkIjtzOjE6IjAiO3M6MTc6InNpbXBsZV9tYXhfd2VpZ2h0IjtzOjA6IiI7czoxNzoic2ltcGxlX21pbl93ZWlnaHQiO3M6MDoiIjtzOjE5OiJzaW1wbGVfbWF4X3F1YW50aXR5IjtzOjA6IiI7czoxOToic2ltcGxlX21pbl9xdWFudGl0eSI7czowOiIiO3M6MTc6InNpbXBsZV9tYXhfYW1vdW50IjtzOjA6IiI7czoxNzoic2ltcGxlX21pbl9hbW91bnQiO3M6MDoiIjtzOjE4OiJzaW1wbGVfc2hvd193ZWlnaHQiO3M6MToiMCI7czoxNjoic2ltcGxlX3VzZV90b3RhbCI7czoxOiIwIjtzOjE4OiJzaW1wbGVfZW1wdHlfZW1haWwiO3M6MDoiIjtzOjEyOiJzaW1wbGVfZGVidWciO3M6MToiMCI7czoyMjoic2ltcGxlX2NvbW1vbl90ZW1wbGF0ZSI7czoxMjI6IntoZWxwfXtsZWZ0X2NvbHVtbn17Y2FydH17Y3VzdG9tZXJ9ey9sZWZ0X2NvbHVtbn17cmlnaHRfY29sdW1ufXtzaGlwcGluZ317cGF5bWVudH17YWdyZWVtZW50fXsvcmlnaHRfY29sdW1ufXtwYXltZW50X2Zvcm19Ijt9')));
    }
    
    public function index() {   
		$this->load->language('module/simple');
        
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {	
            
            if (isset($this->request->post['simple_customer_fields_set']['shipping']) && is_array($this->request->post['simple_customer_fields_set']['shipping'])) {
                $tmp = array();
                foreach ($this->request->post['simple_customer_fields_set']['shipping'] as $key => $value) {
                    $tmp[str_replace('_101_', '.', $key)] = $value;
                }
                $this->request->post['simple_customer_fields_set']['shipping'] = $tmp;
            }
            
            if (isset($this->request->post['simple_company_fields_set']['shipping']) && is_array($this->request->post['simple_company_fields_set']['shipping'])) {
                $tmp = array();
                foreach ($this->request->post['simple_company_fields_set']['shipping'] as $key => $value) {
                    $tmp[str_replace('_101_', '.', $key)] = $value;
                }
                $this->request->post['simple_company_fields_set']['shipping'] = $tmp;
            }
            
            if (isset($this->request->post['simple_shipping_address_fields_set']['shipping']) && is_array($this->request->post['simple_shipping_address_fields_set']['shipping'])) {
                $tmp = array();
                foreach ($this->request->post['simple_shipping_address_fields_set']['shipping'] as $key => $value) {
                    $tmp[str_replace('_101_', '.', $key)] = $value;
                }
                $this->request->post['simple_shipping_address_fields_set']['shipping'] = $tmp;
            }
            
            $simple_common_template = $this->request->post['simple_common_template'];
            $simple_common_template = str_replace(' ', '', $simple_common_template);
            
            $find = array(
    	  			'{cart}',
          			'{shipping}',
          			'{payment}',
                    '{agreement}',
                    '{help}',
                    '{payment_form}'
    			);	
            
            $replace = array(
    	  			'{cart}' => '',
          			'{shipping}' => '',
          			'{payment}' => '',
                    '{agreement}' => '',
                    '{help}' => '',
                    '{payment_form}' => ''
    			);	
    			
            $simple_common_template = trim(str_replace($find, $replace, $simple_common_template));
            
            $find = array(
    	  			'{left_column}{/left_column}',
                    '{right_column}{/right_column}'
    			);	
            
            $replace = array(
    	  			'{left_column}{/left_column}' => '',
          			'{right_column}{/right_column}' => ''
    			);
                
            $simple_common_template = trim(str_replace($find, $replace, $simple_common_template));
            
            if ($simple_common_template == '{customer}') {
                $this->request->post['simple_customer_two_column'] = true;
            } else {
                $this->request->post['simple_customer_two_column'] = false;
            }
            
            $this->model_setting_setting->editSetting('simple', $this->request->post);		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        $this->error['warning'] = $this->config->get('s'.'i'.'m'.'p'.'l'.'e'.'_'.'a'.'t'.'t'.'e'.'n'.'t'.'i'.'o'.'n');
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect($this->url->link('module/simple', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} elseif ($this->config->get('simple_attention') != '') {
			$this->data['error_warning'] = $this->config->get('simple_attention');
		} else {
			$this->data['error_warning'] = '';
		}
        
        if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
			
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/simple', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
        $this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
        
		$this->data['action'] = $this->url->link('module/simple', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['token'] = $this->session->data['token'];
        
        /*
        $this->data['lwa'] = $this->url->link('module/simple/write', 'token=' . $this->session->data['token'], 'SSL');
		*/
        
        $this->data['tab_checkout'] = $this->language->get('tab_checkout');
        $this->data['tab_customer_fields'] = $this->language->get('tab_customer_fields');
        $this->data['tab_company_fields'] = $this->language->get('tab_company_fields');
        $this->data['tab_registration'] = $this->language->get('tab_registration');
        $this->data['tab_registration_fields'] = $this->language->get('tab_registration_fields');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        
        $this->data['text_module_links'] = $this->language->get('text_module_links');
        $this->data['entry_payment_module'] = $this->language->get('entry_payment_module');
        $this->data['entry_shipping_modules'] = $this->language->get('entry_shipping_modules');
        $this->data['text_select_shipping'] = $this->language->get('text_select_shipping');
        $this->data['entry_template'] = $this->language->get('entry_template');
        $this->data['entry_template_description'] = $this->language->get('entry_template_description');
        $this->data['text_simplecheckout'] = $this->language->get('text_simplecheckout');
        $this->data['text_agreement_block'] = $this->language->get('text_agreement_block');
        $this->data['entry_agreement_id'] = $this->language->get('entry_agreement_id');
        $this->data['entry_agreement_text'] = $this->language->get('entry_agreement_text');
        $this->data['entry_agreement_checkbox'] = $this->language->get('entry_agreement_checkbox');
        $this->data['entry_agreement_checkbox_init'] = $this->language->get('entry_agreement_checkbox_init');
        $this->data['text_shipping_block'] = $this->language->get('text_shipping_block');
        $this->data['entry_shipping_title'] = $this->language->get('text_shipping_title');
        $this->data['entry_shipping_address_empty'] = $this->language->get('entry_shipping_address_empty');
        $this->data['text_payment_block'] = $this->language->get('text_payment_block');
        $this->data['entry_payment_address_empty'] = $this->language->get('entry_payment_address_empty');
        $this->data['text_customer_block'] = $this->language->get('text_customer_block');
        $this->data['entry_customer_register'] = $this->language->get('entry_customer_register');
        $this->data['text_user_choice'] = $this->language->get('text_user_choice');
        $this->data['entry_customer_login'] = $this->language->get('entry_customer_login');
        $this->data['entry_customer_type'] = $this->language->get('entry_customer_type');
        $this->data['entry_customer_register_init'] = $this->language->get('entry_customer_register_init');
        $this->data['entry_customer_address_select'] = $this->language->get('entry_customer_address_select');
        $this->data['text_registration_page'] = $this->language->get('text_registration_page');
        $this->data['entry_registration_agreement_id'] = $this->language->get('entry_registration_agreement_id');
        $this->data['entry_registration_agreement_checkbox'] = $this->language->get('entry_registration_agreement_checkbox');
        $this->data['entry_registration_agreement_checkbox_init'] = $this->language->get('entry_registration_agreement_checkbox_init');
        $this->data['entry_registration_captcha'] = $this->language->get('entry_registration_captcha');
        $this->data['text_fields_default'] = $this->language->get('text_fields_default');
        $this->data['entry_field_id'] = $this->language->get('entry_field_id');
        $this->data['entry_field_label'] = $this->language->get('entry_field_label');
        $this->data['entry_field_type'] = $this->language->get('entry_field_type');
        $this->data['entry_field_init'] = $this->language->get('entry_field_init');
        $this->data['entry_field_values'] = $this->language->get('entry_field_values');
        $this->data['entry_field_validation'] = $this->language->get('entry_field_validation');
        $this->data['entry_field_save_to'] = $this->language->get('entry_field_save_to');
        $this->data['entry_shipping_address_full'] = $this->language->get('entry_shipping_address_full');
        $this->data['entry_payment_address_full'] = $this->language->get('entry_payment_address_full');
        $this->data['entry_shipping_address_full_description'] = $this->language->get('entry_shipping_address_full_description');
        $this->data['entry_payment_address_full_description'] = $this->language->get('entry_payment_address_full_description');
        $this->data['text_validation_none'] = $this->language->get('text_validation_none');
        $this->data['text_validation_length'] = $this->language->get('text_validation_length');
        $this->data['text_validation_regexp'] = $this->language->get('text_validation_regexp');
        $this->data['text_validation_values'] = $this->language->get('text_validation_values');
        $this->data['text_validation_not_null'] = $this->language->get('text_validation_not_null');
        $this->data['entry_field_validation_error'] = $this->language->get('entry_field_validation_error');
        $this->data['text_select'] = $this->language->get('text_select');
        $this->data['entry_customer_subscribe'] = $this->language->get('entry_customer_subscribe');
        $this->data['entry_customer_subscribe_init'] = $this->language->get('entry_customer_subscribe_init');
        $this->data['text_add_field'] = $this->language->get('text_add_field');
        $this->data['button_add'] = $this->language->get('button_add');
        $this->data['button_delete'] = $this->language->get('button_delete');
        $this->data['entry_customer_password_confirm'] = $this->language->get('entry_customer_password_confirm');
        $this->data['entry_geoip_init'] = $this->language->get('entry_geoip_init');
        $this->data['entry_shipping_module'] = $this->language->get('entry_shipping_module');
        $this->data['entry_customer_fields'] = $this->language->get('entry_customer_fields');
        $this->data['entry_company_fields'] = $this->language->get('entry_company_fields');
        $this->data['entry_password_length'] = $this->language->get('entry_password_length');
        $this->data['entry_customer_email_field'] = $this->language->get('entry_customer_email_field');
        $this->data['text_hide'] = $this->language->get('text_hide');
        $this->data['text_show_not_required'] = $this->language->get('text_show_not_required');
        $this->data['text_required'] = $this->language->get('text_required');
        $this->data['text_validation_function'] = $this->language->get('text_validation_function');
        $this->data['entry_payment_autoselect_first'] = $this->language->get('entry_payment_autoselect_first');
        $this->data['entry_shipping_autoselect_first'] = $this->language->get('entry_shipping_autoselect_first');
        $this->data['entry_jquery_masked_input_mask'] = $this->language->get('entry_jquery_masked_input_mask');
        $this->data['entry_city_autocomplete'] = $this->language->get('entry_city_autocomplete');
        $this->data['entry_generate_password'] = $this->language->get('entry_generate_password');
        $this->data['entry_placeholder'] = $this->language->get('entry_placeholder');
        $this->data['entry_save_label'] = $this->language->get('entry_save_label');
        $this->data['text_order_minmax'] = $this->language->get('text_order_minmax');
        $this->data['entry_use_total'] = $this->language->get('entry_use_total');
        $this->data['entry_min_amount'] = $this->language->get('entry_min_amount');
        $this->data['entry_max_amount'] = $this->language->get('entry_max_amount');
        $this->data['entry_min_quantity'] = $this->language->get('entry_min_quantity');
        $this->data['entry_max_quantity'] = $this->language->get('entry_max_quantity');
        $this->data['entry_min_weight'] = $this->language->get('entry_min_weight');
        $this->data['entry_max_weight'] = $this->language->get('entry_max_weight');
        $this->data['entry_payment_method'] = $this->language->get('entry_payment_method');
        $this->data['text_shipping_address_block'] = $this->language->get('text_shipping_address_block');
        $this->data['entry_shipping_address_select'] = $this->language->get('entry_shipping_address_select');
        $this->data['entry_shipping_address_show'] = $this->language->get('entry_shipping_address_show');
        $this->data['entry_shipping_address_fields'] = $this->language->get('entry_shipping_address_fields');
        $this->data['entry_help_text'] = $this->language->get('entry_help_text');
        $this->data['entry_help_id'] = $this->language->get('entry_help_id');
        $this->data['text_help_block'] = $this->language->get('text_help_block');
        $this->data['entry_hide'] = $this->language->get('entry_hide');
        $this->data['entry_hide_if_logged'] = $this->language->get('entry_hide_if_logged');
        $this->data['entry_empty_email'] = $this->language->get('entry_empty_email');
        $this->data['entry_show_weight'] = $this->language->get('entry_show_weight');
        $this->data['entry_fields_for_reload'] = $this->language->get('entry_fields_for_reload');
        $this->data['entry_use_cookies'] = $this->language->get('entry_use_cookies');
        $this->data['entry_show_will_be_registerd'] = $this->language->get('entry_show_will_be_registerd');
        $this->data['entry_guest_checkout'] = $this->language->get('entry_guest_checkout');
        
        $this->init_field('simple_links', array());
        $this->init_field('simple_common_template', '{left_column}{cart}{customer}{/left_column}{right_column}{shipping}{payment}{agreement}{/right_column}');
        $this->init_field('simple_common_view_agreement_id');
        $this->init_field('simple_common_view_agreement_text');
        $this->init_field('simple_common_view_agreement_checkbox');
        $this->init_field('simple_common_view_agreement_checkbox_init');
        $this->init_field('simple_shipping_view_title');
        $this->init_field('simple_shipping_view_address_empty');
        $this->init_field('simple_payment_view_address_empty');
        $this->init_field('simple_payment_view_autoselect_first');
        $this->init_field('simple_shipping_view_autoselect_first');
        $this->init_field('simple_customer_action_register');
        $this->init_field('simple_customer_view_login');
        $this->init_field('simple_customer_view_customer_type');
        $this->init_field('simple_customer_view_customer_register_init');
        $this->init_field('simple_customer_view_address_select');
        $this->init_field('simple_registration_agreement_id');
        $this->init_field('simple_registration_agreement_checkbox');
        $this->init_field('simple_registration_agreement_checkbox_init');
        $this->init_field('simple_registration_captcha');
        $this->init_field('simple_shipping_view_address_full', array());
        $this->init_field('simple_payment_view_address_full', array());
        $this->init_field('simple_customer_action_subscribe');
        $this->init_field('simple_customer_view_customer_subscribe_init');
        $this->init_field('simple_registration_subscribe');
        $this->init_field('simple_registration_subscribe_init');
        $this->init_field('simple_customer_view_password_confirm');
        $this->init_field('simple_customer_view_password_length_min');
        $this->init_field('simple_customer_view_password_length_max');
        $this->init_field('simple_registration_password_confirm');
        $this->init_field('simple_registration_password_length_min');
        $this->init_field('simple_registration_password_length_max');
        $this->init_field('simple_registration_view_customer_type');
        $this->init_field('simple_customer_fields_set');
        $this->init_field('simple_company_fields_set');
        $this->init_field('simple_customer_view_email');
        $this->init_field('simple_customer_generate_password');
        $this->init_field('simple_registration_generate_password');
        $this->init_field('simple_show_shipping_address');
        $this->init_field('simple_shipping_view_address_select');
        $this->init_field('simple_shipping_address_fields_set');
        $this->init_field('simple_use_total');
        $this->init_field('simple_min_amount');
        $this->init_field('simple_max_amount');
        $this->init_field('simple_min_quantity');
        $this->init_field('simple_max_quantity');
        $this->init_field('simple_min_weight');
        $this->init_field('simple_max_weight');
        $this->init_field('simple_debug');
        $this->init_field('simple_common_view_help_id');
        $this->init_field('simple_common_view_help_text');
        $this->init_field('simple_aceshop');
        $this->init_field('simple_shipping_methods_hide');
        $this->init_field('simple_payment_methods_hide');
        $this->init_field('simple_customer_hide_if_logged');
        $this->init_field('simple_empty_email');
        $this->init_field('simple_show_weight');
        $this->init_field('simple_fields_for_reload');
        $this->init_field('simple_use_cookies');
        $this->init_field('simple_show_will_be_registered');
        $this->init_field('simple_disable_guest_checkout');
        
        $this->load->model('setting/extension');
        
        $payment_extensions = $this->model_setting_extension->getInstalled('payment');
        $tmp = array();
        foreach ($payment_extensions as $extension) {
            if ($this->config->get($extension . '_status')) {
                $tmp[] = $extension;
            }
        }
        $payment_extensions = $tmp;
        
        $this->data['payment_extensions'] = array();
        
        $files = glob(DIR_APPLICATION . 'controller/payment/*.php');
		
		if ($files) {
			foreach ($files as $file) {
				$extension = basename($file, '.php');
				
                if (in_array($extension, $payment_extensions)) {
                    $this->load->language('payment/' . $extension);
                    $this->data['payment_extensions'][$extension] = $this->language->get('heading_title');
				}
			}
		}
      
        $shipping_extensions = $this->model_setting_extension->getInstalled('shipping');
        $tmp = array();
        foreach ($shipping_extensions as $extension) {
            if ($this->config->get($extension . '_status')) {
                $tmp[] = $extension;
            }
        }
        $shipping_extensions = $tmp;
        
        $this->data['shipping_extensions'] = array();
        
        $files = glob(DIR_APPLICATION . 'controller/shipping/*.php');
		
		if ($files) {
			foreach ($files as $file) {
				$extension = basename($file, '.php');
				
                if (in_array($extension, $shipping_extensions)) {
                    $this->load->language('shipping/' . $extension);
                    $this->data['shipping_extensions'][$extension] = $this->language->get('heading_title');
				}
			}
		}
        
        $shipping_codes = array_keys($this->data['shipping_extensions']);
        
        $this->data['shipping_extensions_for_customer'] = array_diff(isset($this->data['simple_customer_fields_set']['shipping']) ? array_keys($this->data['simple_customer_fields_set']['shipping']) : array(),$shipping_codes);
        $this->data['shipping_extensions_for_company'] = array_diff(isset($this->data['simple_company_fields_set']['shipping']) ? array_keys($this->data['simple_company_fields_set']['shipping']) : array(),$shipping_codes);
        $this->data['shipping_extensions_for_shipping_address'] = array_diff(isset($this->data['simple_shipping_address_fields_set']['shipping']) ? array_keys($this->data['simple_shipping_address_fields_set']['shipping']) : array(),$shipping_codes);
        
        $this->load->model('localisation/language');
        $languages = $this->model_localisation_language->getLanguages();
        $this->data['languages'] = array();
        foreach ($languages as $language) {
            $language['code'] = str_replace('-', '_', strtolower($language['code']));
            $this->data['languages'][] = $language;
        }
        $this->data['current_language'] = strtolower($this->config->get('config_admin_language'));
        
        $this->load->model('catalog/information');
		$this->data['informations'] = $this->model_catalog_information->getInformations();
        
        $this->init_field('simple_customer_fields_settings', array());
        $this->init_field('simple_custom_fields_settings', array());
        
        $this->data['simple_customer_all_fields_settings'] = $this->data['simple_customer_fields_settings'] + (!empty($this->data['simple_custom_fields_settings']) ? $this->data['simple_custom_fields_settings'] : array());
        
        $this->data['simple_shipping_address_fields_settings'] = array();
        
        $shipping_address_fields = array('main_firstname','main_lastname','main_company','main_company_id','main_tax_id','main_address_1','main_address_2','main_city','main_postcode','main_zone_id','main_country_id');
        foreach ($this->data['simple_customer_fields_settings'] as $settings) {
            if (in_array($settings['id'], $shipping_address_fields)) {
                $this->data['simple_shipping_address_fields_settings'][$settings['id']] = $settings;
            }
        }
        foreach ($this->data['simple_custom_fields_settings'] as $settings) {
            $this->data['simple_shipping_address_fields_settings'][$settings['id']] = $settings;
        }
        
        $this->init_field('simple_company_fields_settings', array());

        $this->load->model('localisation/country');
        $this->data['countries'] = $this->model_localisation_country->getCountries();
        
        $this->load->model('localisation/zone');
        $this->data['zones'] = $this->model_localisation_zone->getZonesByCountryId($this->data['simple_customer_fields_settings']['main_country_id']['init']);
        
        $this->data['zone_action'] = $this->url->link('module/simple/zone', 'token=' . $this->session->data['token'], 'SSL');
		
        $this->template = 'module/simple.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
    
    private function init_field($field_name, $default_value = '') {
        if (isset($this->request->post[$field_name])) {
			$this->data[$field_name] = $this->request->post[$field_name];
		} elseif ($field_settings = $this->config->get($field_name)) {
            $this->data[$field_name] = $field_settings;
        }
        
        if (empty($this->data[$field_name])) {
            $this->data[$field_name] = $default_value;
        }
    }
    
    public function zone() {
		$output = '<option value="">' . $this->language->get('text_select') . '</option>';
		
		$this->load->model('localisation/zone');

    	$results = $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']);
        
      	foreach ($results as $result) {
        	$output .= '<option value="' . $result['zone_id'] . '">' . $result['name'] . '</option>';
    	} 
		
		if (!$results) {
		  	$output .= '<option value="0">' . $this->language->get('text_none') . '</option>';
		}
	
		$this->response->setOutput($output);
  	}  

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/simple')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
        
        if (empty($this->request->post['simple_common_template'])) {
            $this->error['warning'] = $this->language->get('error_exists');
			$this->error['error_simple_common_template'] = $this->data['error_simple_common_template'] = $this->language->get('error_simple_common_template');
		}
        
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>