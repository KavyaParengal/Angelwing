# Generated by Django 4.2 on 2023-06-06 14:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("Outsiders", "0008_adoptionform"),
    ]

    operations = [
        migrations.AddField(
            model_name="adoptionform",
            name="status",
            field=models.CharField(default=1, max_length=100),
            preserve_default=False,
        ),
    ]
