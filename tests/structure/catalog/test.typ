#import "/src/lib.typ": book
#set page(height: auto)

#book(
  // Cataloging-in-publication data
  catalog: (
    id: "A000",
    place: "Bookland",
    publisher: "Minimal Books",
    isbn: "000-0-00-000000-0",
    subjects: ("Book Theme", "Book Subject", "Book Area"),
    access: "Title",
    ddc: "000.00",
    udc: "000.000",
    before: [
      Copyright #sym.copyright 2025 by Book Author\
      All rights reserved. No part of this publication may be reproduced, stored
      in a retrieval system, or transmitted in any form or by any means—electronic,
      mechanical, photocopying, recording, or otherwise—without the prior written
      permission of the publisher, except in the case of brief quotations embodied
      in critical articles or reviews.
      
      Cover and book design by mayconfmelo.\
      Made in Brazil.\
      Printed Worldwide.\
      First edition.
      
      #v(1fr)
      
      #align(center)[*Library of Congress Cataloging-in-Publication Data*]
    ],
    after: align(center)[
      _Minimal Books_ is a trademark of min-book, registered or pending
      registration in applicable jurisdictions.

      For permission requests, write to the publisher at:\
      Minimal Books\
      
      1234 Maple Avenue, Suite 567\
      Great City, NY 10001\
      United States\
      permissions\@min-books.com
    ]
  ),
  // Additional book data
  title: "Book Title",
  subtitle: "Book subtitle, not more than two lines long",
  authors: "Book Author",
  titlepage: none,
  cover: none,
  toc: none,
  volume: 1,
  cfg: (
    font-usedefaults: true,
    two-sided: false,
    cover-back: false,
  ),
  []
)