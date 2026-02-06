import { application } from "controllers/application"

import BidController from "controllers/bid_controller"
application.register("bid", BidController)

import CountdownController from "controllers/countdown_controller"
application.register("countdown", CountdownController)

import GalleryController from "controllers/gallery_controller"
application.register("gallery", GalleryController)

import NavbarController from "controllers/navbar_controller"
application.register("navbar", NavbarController)
