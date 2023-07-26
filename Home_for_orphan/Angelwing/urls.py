from django.urls import path
from . import views

urlpatterns = [

    path("", views.login_page,name="loginpage"),
    path("forgot_password", views.forgot_password,name="forgot_password"),

    path("admin_dashboard", views.admin_dashboard,name="admin_dashboard"),
    path("admin_add_schemes", views.admin_add_schemes,name="admin_add_schemes"),
    path("admin_edit_schemes", views.admin_edit_schemes,name="admin_edit_schemes"),
    path("admin_view_adoption", views.admin_view_adoption,name="admin_view_adoption"),
    path("admin_view_blogs", views.admin_view_blogs,name="admin_view_blogs"),
    path("admin_view_clothdonation", views.admin_view_clothdonation,name="admin_view_clothdonation"),
    path("admin_view_events", views.admin_view_events,name="admin_view_events"),
    path("admin_view_feedback", views.admin_view_feedback,name="admin_view_feedback"),
    path("admin_view_foodDonation", views.admin_view_foodDonation,name="admin_view_foodDonation"),
    path("admin_view_orphans", views.admin_view_orphans,name="admin_view_orphans"),
    path("admin_view_moneydonation", views.admin_view_moneydonation,name="admin_view_moneydonation"),
    path("admin_view_orphanages", views.admin_view_orphanages,name="admin_view_orphanages"),
    path("admin_view_scheme", views.admin_view_scheme,name="admin_view_scheme"),
    path("admin_view_users",views.admin_view_users,name="admin_view_users"),
    path("admin_view_approvedorphanages",views.admin_view_approvedorphanages,name="admin_view_approvedorphanages"),
    path("admin_view_approvedAdoption",views.admin_view_approvedAdoption,name="admin_view_approvedAdoption"),
    path("admin_add_adoptionnotification/<int:id>",views.admin_add_adoptionnotification,name="admin_add_adoptionnotification"),
    path("add_adoption_notify",views.add_adoption_notify,name="add_adoption_notify"),
    path("adminviewadoptionnotification",views.adminviewadoptionnotification,name="adminviewadoptionnotification"),


    path("orphanage_dashboard",views.orphanage_dashboard,name="orphanage_dashboard"),

    path("orphanage_add_blogs",views.orphanage_add_blogs,name="orphanage_add_blogs"),
    path("orphanage_add_events",views.orphanage_add_events,name="orphanage_add_events"),
    path("orphanage_add_notification",views.orphanage_add_notification,name="orphanage_add_notification"),
    path("orphanage_add_orphans",views.orphanage_add_orphans,name="orphanage_add_orphans"),
    path("orphanage_add_rules",views.orphanage_add_rules,name="orphanage_add_rules"),

    path("orphanage_edit_blogs",views.orphanage_edit_blogs,name="orphanage_edit_blogs"),
    path("orphanage_edit_events",views.orphanage_edit_events,name="orphanage_edit_events"),
    path("orphanage_edit_notification",views.orphanage_edit_notification,name="orphanage_edit_notification"),
    path("orphanage_edit_orphans",views.orphanage_edit_orphans,name="orphanage_edit_orphans"),
    path("orphanage_edit_rules",views.orphanage_edit_rules,name="orphanage_edit_rules"),

    path("orphanage_registration",views.orphanage_registration,name="orphanage_registration"),

    path("orphanage_view_adoption",views.orphanage_view_adoption,name="orphanage_view_adoption"),
    path("orphanage_view_blogs",views.orphanage_view_blogs,name="orphanage_view_blogs"),
    path("orphanage_view_clothdonation",views.orphanage_view_clothdonation,name="orphanage_view_clothdonation"),
    path("orphanage_view_events",views.orphanage_view_events,name="orphanage_view_events"),
    path("orphanage_view_feedback",views.orphanage_view_feedback,name="orphanage_view_feedback"),
    path("orphanage_view_foodDonation",views.orphanage_view_foodDonation,name="orphanage_view_foodDonation"),
    path("orphanage_view_moneydonation",views.orphanage_view_moneydonation,name="orphanage_view_moneydonation"),
    path("orphanage_view_notification",views.orphanage_view_notification,name="orphanage_view_notification"),
    path("orphanage_view_orphans",views.orphanage_view_orphans,name="orphanage_view_orphans"),
    path("orphanage_view_rules",views.orphanage_view_rules,name="orphanage_view_rules"),
    path("orphanage_view_schemes",views.orphanage_view_schemes,name="orphanage_view_schemes"),




    path("orphanage_register",views.orphanage_register,name="orphanage_register"),

    path("add_schemes",views.add_schemes,name="add_schemes"),
    path("adminviewscheme",views.adminviewscheme,name="adminviewscheme"),
    path("admindeletescheme/<int:scheme_id>",views.admindeletescheme,name="admindeletescheme"),
    path("admineditscheme/<int:scheme_id>",views.admineditscheme,name="admineditscheme"),
    path("<int:scheme_id>/adminschemeupdate/",views.adminschemeupdate,name="adminschemeupdate"),

    path("add_rules",views.add_rules,name="add_rules"),
    path("viewrules",views.viewrules,name="viewrules"),
    path("deleterules/<int:rules_id>",views.deleterules,name="deleterules"),
    path("editrules/<int:rules_id>",views.editrules,name="editrules"),
    path("<int:rules_id>/orphanageupdaterules/",views.orphanageupdaterules,name="orphanageupdaterules"),

    path("add_blog",views.add_blog,name="add_blog"),
    path("viewblogs",views.viewblogs,name="viewblogs"),
    path("deleteblogs/<int:blog_id>",views.deleteblogs,name="deleteblogs"),
    path("editblogs/<int:blog_id>",views.editblogs,name="editblogs"),
    path("<int:blog_id>/updateblogs/",views.updateblogs,name="updateblogs"),

    path("add_events",views.add_events,name="add_events"),
    path("viewevents",views.viewevents,name="viewevents"),
    path("delete_events/<int:event_id>",views.delete_events,name="delete_events"),
    path("editevents/<int:event_id>",views.editevents,name="editevents"),
    path("<int:event_id>/update_events/",views.update_events,name="update_events"),

    path("add_notification",views.add_notification,name="add_notification"),
    path("viewnotification",views.viewnotification,name="viewnotification"),
    path("deletenotification/<int:notification_id>",views.deletenotification,name="deletenotification"),
    path("editnotification/<int:notification_id>",views.editnotification,name="editnotification"),
    path("<int:notification_id>/orphanageupdatenotification/",views.orphanageupdatenotification,name="orphanageupdatenotification"),

    path("add_orphan",views.add_orphan,name="add_orphan"),
    path("viewallorphans",views.viewallorphans,name="viewallorphans"),
    path("deleteorphans/<int:orphan_id>",views.deleteorphans,name="deleteorphans"),
    path("editorphans/<int:orphan_id>",views.editorphans,name="editorphans"),
    path("<int:orphan_id>/orphanageupdateorphan/",views.orphanageupdateorphan,name="orphanageupdateorphan"),


    path("adminviewallorphanage",views.adminviewallorphanage,name="adminviewallorphanage"),
    path("adminapprove/<int:orphanage_id>",views.adminapprove,name="adminapprove"),
    path("adminapprovedorphanages",views.adminapprovedorphanages,name="adminapprovedorphanages"),
    path("adminorphanagereject/<int:orphanage_id>",views.adminorphanagereject,name="adminorphanagereject"),

    path("login_user",views.login_user,name="login_user"),

    path("logout",views.logout,name="logout"),

    path("orphanageviewscheme",views.orphanageviewscheme,name="orphanageviewscheme"),

    path("adminviewblog",views.adminviewblog,name="adminviewblog"),

    path("adminvieworphans",views.adminvieworphans,name="adminvieworphans"),

    path("adminviewevent",views.adminviewevent,name='adminviewevent'),

    path("adminviewusers",views.adminviewusers,name="adminviewusers"),

    path("adminviewadoption",views.adminviewadoption,name="adminviewadoption"),
    path("adminapproveAdoption/<int:adoption_id>",views.adminapproveAdoption,name="adminapproveAdoption"),
    path("viewAdminapprovedAdoption",views.viewAdminapprovedAdoption,name="viewAdminapprovedAdoption"),
    path("adminrejectAdoption/<int:adoption_id>",views.adminrejectAdoption,name="adminrejectAdoption"),

    path("adminviewfeedback",views.adminviewfeedback,name="adminviewfeedback"),

    path("adminviewfdonation",views.adminviewfdonation,name="adminviewfdonation"),

    path("adminviewmdonation",views.adminviewmdonation,name="adminviewmdonation"),

    path("adminviewcdonation",views.adminviewcdonation,name="adminviewcdonation"),

    path("orphanageviewfdonation",views.orphanageviewfdonation,name="orphanageviewfdonation"),

    path("orphanageviewmdonation",views.orphanageviewmdonation,name="orphanageviewmdonation"),

    path("orphanageviewcdonation",views.orphanageviewcdonation,name="orphanageviewcdonation"),

    path("orphanageviewadoption",views.orphanageviewadoption,name="orphanageviewadoption"),

    path("orphanageviewfeedback",views.orphanageviewfeedback,name="orphanageviewfeedback")
]